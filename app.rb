require 'sinatra'
require 'oauth2'
require 'json'
require_relative 'app/model/event'
require_relative 'app/model/calendar'
require_relative 'app/model/attending'
require_relative 'app/model/database'

configure do
  enable :sessions
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "app/public") }
  set :views, Proc.new { File.join(root, "app/views") }
end

get '/next_event' do
  content_type :json
  {"date"=>Event.current}.to_json
end

get '/attendings' do
  content_type :json
  Attending.list.to_json
end

get '/auth/github' do
  url = client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => 'user')
  puts "Redirecting to URL: #{url.inspect}"
  redirect url
end
 
get '/auth/github/callback' do
  access_token = client.auth_code.get_token params[:code], redirect_uri: redirect_uri
  user = JSON.parse access_token.get("https://api.github.com/user").body
  Attending.add user
  redirect to('/')
end

def client
  OAuth2::Client.new ENV['GITHUB_CLIENT_ID'],
                     ENV['GITHUB_CLIENT_SECRET'],
                     site: 'https://github.com',
                     authorize_url: 'https://github.com/login/oauth/authorize',
                     token_url: 'https://github.com/login/oauth/access_token'
end
 
def redirect_uri(path = '/auth/github/callback', query = nil)
  uri = URI.parse(request.url)
  uri.path  = path
  uri.query = query
  uri.to_s
end
