set :application, "scrumcook.com"
set :repository,  "git@github.com:sanjusoftware/scrumcook.git"
set :branch, "master"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:forward_agent] = true

set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :user, "root"

role :web, "dev-utility-lx38.amdc.mckinsey.com"                          # Your HTTP server, Apache/etc
role :app, "dev-utility-lx38.amdc.mckinsey.com"                          # This may be the same as your `Web` server
role :db,  "dev-utility-lx38.amdc.mckinsey.com", :primary => true # This is where Rails migrations will run


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

# tasks
namespace :deploy do
  task :migrate do
    run "cd #{current_path}; /usr/bin/rake migrate environment=production"
  end

  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end

  #desc "Sync the public/assets directory."
  #task :assets do
  #  system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
  #end

  desc "install the necessary prerequisites"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end

end

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:update_code', 'deploy:migrate'
