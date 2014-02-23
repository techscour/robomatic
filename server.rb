require 'sinatra'
require 'uri'

composed = []

get '/'do
  "Welcome to Robomatic"
end

get '/command' do
  decoded = URI.decode(params[:text]);
  "command #{decoded}"
end

get '/compose' do
  decoded = URI.decode(params[:text]);
  composed << decoded
  "composed #{decoded}"
end

get '/compile' do
  'compile complete'
end

get '/check' do
  'check complete'
end

get '/clear' do
  composed = []
  'cleared'
end

get '/composed' do
  composed.join("\n")
end
