set :application, "lalibre"
set :repository,  "/Users/ojcar/apps/items/.git"
#set :local_repository, "/Users/ojcar/apps/items/.git"

#set :scm, :subversion
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/nerduchis/webapps/lalibre"

role :web, "web158.webfaction.com"                          # Your HTTP server, Apache/etc
role :app, "web158.webfaction.com"                          # This may be the same as your `Web` server
role :db,  "web158.webfaction.com", :primary => true # This is where Rails migrations will run

set :user, "nerduchis"
set :scm_username, "ojcar"
set :use_sudo, false
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end