require 'sinatra'
require './parselib.rb'
require 'uri'
include Preprocessor

statements = []
commands = []
compiled = nil

def escape(x)
  x = x.gsub("{","\\{").gsub("(","\\(").gsub("[","\\[")
  x.gsub("}","\\}").gsub(")","\\)").gsub("]","\\]")
end

def comber(query,statements)
  regex = nil
  query = query.strip
  replaced = nil
  if query[-1] == '?'
    query[-1] = '.'
    query = escape(query)
    replaced = '^' + query + '$'
  elsif query.include?('?')
    query = escape(query)
    replaced = '^' + query.gsub("?",'.+') + '$'
  else
   return 'EMPTY'
  end
  regex = Regexp.new(replaced)
  statements.select{|x| regex.match(x)}
end

def compiler(statements,commands)
  code = []
  commands = []
  lines = statements.collect{|x| x.strip }.select{|x| !x.empty?} 
  packaged = lines.collect{|x| package(parse(x))}
  #packaged.each{|x| puts x.inspect}
  by_literals = packaged.group_by{|x| x[:literals]}
  changeologies = by_literals['is a changeology']
  constellations = by_literals['is a constellation in']
  changeables = by_literals['is a changeable in']
  checkpoints = by_literals['is a checkpoint in']
  comprehensives = by_literals['is comprehensive']
  at_checkpoint = by_literals['is at checkpoint in']
  code << "def commander(statement,command)" 
  code << "  case command"
  changeologies.each() do |changeology|
    changeology_id = changeology[:variables][0]
    constellations_of = constellations.select{|x| x[:variables][1] == changeology_id}
    constellations_of.each() do |constellation|
     constellation_id = constellation[:variables][0].gsub("'","\\'")
     changeables_of = changeables.select{|x| x[:variables][1] == constellation_id} 
     checkpoints_of = checkpoints.select{|x| x[:variables][1] == constellation_id} 
     at_checkpoints_of = at_checkpoint.select{|x| x[:variables][2] == constellation_id}
     #puts changeables_of.size
     #puts checkpoints_of.size
     #puts at_checkpoints_of.size
     changeables_of.each() do |changeable|
       changeable_id = changeable[:variables][0].gsub("'","\\'")
       checkpoints.each() do |checkpoint|
         checkpoint_id = checkpoint[:variables][0].gsub("'","\\'")
         code << "    when '(#{changeable_id}) is at checkpoint (#{checkpoint_id}) in (#{constellation_id})!'" 
         code << "      old = comb('(#{changeable_id}) is at checkpoint (?) in (#{constellation_id})!')" 
         code << "      statements.delete(old)"
         code << "      statments << '(#{changeable_id}) is at checkpoint (#{checkpoint_id}) in (#{constellation_id}).'"
         commands << "(#{changeable_id}) is at checkpoint (#{checkpoint_id}) in (#{constellation_id})." 
        end
      end
    end
  end
  code << "  end" 
  code << "end" 
  puts code.join("\n")
end

#compiler(statements,commands)

get '/'do
  "Welcome to Robomatic"
end

get '/command' do
  decoded = URI.decode(params[:text]);
  if commands.include(decoded)
    commander(decoded)
    return 'OK'
  else
    return 'UNKNOWN COMMAND'
end

get '/compose' do
  decoded = URI.decode(params[:text]);
  statements << decoded
  "composed #{decoded}"
end

get '/comb' do
  decoded = URI.decode(params[:text]);
  comber(decoded,statements)
end

get '/compile' do
  code = compiler(statements,commands);
  eval(code)
  code
end

get '/commands' do
  commands.join("\n")
end

get '/check' do
  'check complete'
end

get '/clean' do
  statements = []
  commands = []
  'cleaned'
end

get '/composed' do
  statements.join("\n")
end
