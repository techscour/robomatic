require 'sinatra'
require 'uri'

composed = []

get '/'do
  "Welcome to Robomatic"
end

get '/command' do
  "command #{params[:text]}"
end

get '/compose' do
  "composed #{params[:text]}"
end

get '/compile' do
  'compile complete'
end

get '/clear' do
  composed = []
  'cleared'
end

