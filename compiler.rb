require './parselib.rb'
require 'pry'
include Preprocessor

statements = [
"[John's Status] is a changeology.",
"[John's Location] is a constellation in (John's Status).",
"(John's Location) is comprehensive.",
"[John H] is a changeable in (John's Location).",
"[At Home] is a checkpoint in (John's Location).",
"[At Work] is a checkpoint in (John's Location).",
"[Visiting] is a checkpoint in (John's Location).",
"[Shopping] is a checkpoint in (John's Location).",
"[Elsewhere] is a checkpoint in (John's Location).",
"(John H) is at checkpoint (At Home) in (John's Location).",
"[Home To Work] is a change in (John's Location).",
"(Home To Work) commences at (At Home).",
"(Home To Work) concludes at (At Work).",
"[John Is Awake Or Asleep] is a constellation in (John's Status).",
"(John Is Awake Or Asleep) is comprehensive.",
"[John H] is a changeable in (John Is Awake Or Asleep).",
"[John Is Awake] is a checkpoint in (John Is Awake Or Asleep).",
"[John Is Asleep] is a checkpoint in (John Is Awake Or Asleep).",
"(John H) is at checkpoint (John Is Awake) in (John Is Awake Or Asleep)."
]

commands = []
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

compiler(statements,commands)

