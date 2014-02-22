require 'erb'

abc = {:alpha=>1,:beta=>2,:gamma=>3}

def f1(vals)
   template = "
alpha: <%= abc[:alpha] %>
beta: <%= abc[:beta] %>
gamma: <%= abc[:gamma] %>"
   ERB.new(template).result
end

puts f1(abc)
