require "rvm/capistrano"
require "bundler/capistrano"
set :application, "office_hours"
set :repository,  "git://github.com/alexcp/Montreal.rb-Office-Hours.git"

set :scm, :git
set :use_sudo, false

set(:run_method) { use_sudo ? :sudo : :run }

default_run_options[:pty] = true

set :user, "deployer"
set :group, user
set :runner, user

set :host, "#{user}@198.199.68.68"

role :web, host
role :app, host

set :deploy_to, "/home/#{user}/app/#{application}"

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && bundle exec thin start -d"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && bundle exec thin stop"
  end

  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end

  task :cold do
    run "type bundle || { gem install bundler --no-rdoc --no-ri; }"
    deploy.update
    deploy.start
  end
end
