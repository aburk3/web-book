ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "starts console"
task :console do
  Pry.start
end
