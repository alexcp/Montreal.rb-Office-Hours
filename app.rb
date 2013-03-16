require 'sinatra'
require_relative 'app/model/google_calendar'


configure do
  enable :sessions
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "app/public") }
  set :views, Proc.new { File.join(root, "app/views") }
end

get '/' do
  erb :index
end
