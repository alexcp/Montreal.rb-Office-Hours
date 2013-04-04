require 'rubygems'
require 'sinatra'
 
set :environment, :production
set :port, 8000
disable :run, :reload
 
require './app'
 
run Sinatra::Application
