require 'bundler/capistrano'

# RVM
require "rvm/capistrano"
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3@ontohub'

hostname = 'ontohub.org'

set :application, 'ontohub'
set :scm, :git
set :repository, "git@github.com:#{application}/#{application}.git"
set :deploy_to, "/srv/http/#{hostname}"

set :user, 'ontohub'
set :use_sudo, false
set :deploy_via, :remote_cache

role :app, hostname
role :web, hostname
role :db,  hostname, :primary => true

def rake_command(cmd)
  run "cd #{current_path} && bundle exec rake #{cmd}", :env => { :RAILS_ENV => rails_env }
end

Dir[File.dirname(__FILE__) + "/deploy/*.rb"].each{|f| load f }
