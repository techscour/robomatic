

module Preprocessor

    def parse(x)
      x = x.strip()
      stack = []
      tokens = []
      token = ''
      chars = x.split('')
      final = chars.pop()
      chars.each() do |char|
        if '[({'.include?(char)
          tokens.push token.strip()
          token = ''
        end
        token += char
        if '])}'.include?(char)
          tokens.push token.strip()
          token = ''
        end
      end
      token = token.strip()
      tokens.push(token) unless token == ''
      tokens << final
      tokens
    end

    def package(x)
      result = {}
      result[:literals] = []
      result[:variables] = []
      result[:punctuation] = x.pop()
      x.each() do |token|
        first = token[0]
        if '[({'.include?(first)
    	  result[:variables] << unwrap(token)
        else
    	  result[:literals] << token
        end
      end
      result
    end

    def unwrap(x)
      x[1..-1]
    end
end

if true 
  include Preprocessor
  t1 = 'omega [alpha] beta (tau) gamma {delta} rho.'
  result = package(parse(t1))
  puts result
end

