require 'pry'

module Preprocessor

    def parse(x)
      x = x.strip()
      depth = 0
      tokens = []
      token = ''
      chars = x.chars
      final = chars.pop()
      chars.each() do |char|
        if '[({'.include?(char)
          depth += 1
          if depth == 1
            tokens.push token.strip()
            token = ''
          end
        end
        token += char
        if '])}'.include?(char)
          depth -= 1
          if depth == 0
            tokens.push token.strip()
            token = ''
          end
        end
      end
      throw "depth is #{depth}" if depth != 0 
      tokens << token 
      tokens = tokens.collect{|x| x.strip() }.select{|x| x != "" }
      tokens << final
      tokens
    end

    def package(x)
      result = {}
      result[:decl] = false
      result[:literals] = []
      result[:variables] = []
      result[:punctuation] = x.pop()
      x.each() do |token|
        first = token[0]
        if '[({'.include?(first)
      	  result[:decl] = true if first == '['
    	  result[:variables] << unwrap(token)
        else
    	  result[:literals] << token
        end
      end
      result[:literals] = result[:literals].join(' ')
      result
    end

    def unwrap(x)
      x[1..-2]
    end
end

if false 
  include Preprocessor
  t1 = 'omega [alpha] beta (tau) gamma {delta} rho.'
  result = package(parse(t1))
  puts result
end

if false 
  include Preprocessor
  t1 = 'omega [alpha] beta (tau) gamma {[ID] this is a (that)} rho.'
  result = package(parse(t1))
  puts result
end

if false 
  STDIN.read.split("\n").each do |a|
    a = a.strip
    next if a.empty?
    puts a
  end
end
