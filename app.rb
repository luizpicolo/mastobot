require 'sinatra'
require_relative 'lib/bot'

get '/' do
  @publications = Bot.new('db/out.txt').lasted_publications(6)
  erb :index 
end