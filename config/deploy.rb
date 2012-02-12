set :application, "NewYouth"
set :deploy_to, "/usr/local/webservice/htdocs/#{application}"

# Edit Capfile and add the following to it. This ensures that remote capistrano deployment does not fork a remote shell using command “sh -c”. Some hosting servers do not allow remote shells.
default_run_options[:shell] = false

# set :use_sudo, true
set :use_sudo, false


# Whatever you set here will be taken set as the default RAILS_ENV value
# on the server. Your app and your hourly/daily/weekly/monthly scripts
# will run with RAILS_ENV set to this value.
set :rails_env, "production"

# NOTE: for some reason Capistrano requires you to have both the public and
# the private key in the same folder, the public key should have the
# extension ".pub".
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_rsa"]

set :scm, :git
set :scm_verbose, true
set :branch, "master"
#set :scm_user, 'alexchien'
#set :scm_passphrase, "alexgem"
set :repository,  "git@github.com:AlexChien/NewYouth.git"
set :deploy_via, :remote_cache


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

# 180 上跑rails应用的用户
# set :user, "mongrel"
# set :runner, "mongrel"

# 184 上跑rails应用的用户
set :user, "eywww"
set :runner, "eywww"

set :rails_env, "production"

# Your EC2 instances. Use the ec2-xxx....amazonaws.com hostname, not
# any other name (in case you have your own DNS alias) or it won't
# be able to resolve to the internal IP address.
set :domain, "180.153.142.125"
role :app, domain
role :web, domain
#role :product, "192.168.1.1"
#role :pre_product, "192.168.1.2"
role :db,  domain, :primary => true

# 不用mongrel，改用thin运行本应用
## Add mongrel cluster support ##
require 'mongrel_cluster/recipes'
set :mongrel_conf, "#{shared_path}/config/mongrel_cluster.yml"
set :mongrel_user, "mongrel"


# add misc task here
namespace :deploy do

  # 覆盖capistrano默认行为，添加thin的启动停止命令
  # desc "用应用下的config/thin.yml用thin启动应用"
  # %w(start stop restart).each do |action|
  #   desc "#{action} the Thin processes"
  #   task action.to_sym do
  #     find_and_execute_task("thin:#{action}")
  #   end
  # end

  desc "Generate database.yml and Create asset packages for production, minify and compress js and css files"
  after "deploy:update_code", :roles => [:web] do
    database_yml
    thin_yml
    app_config
  end

  # add soft link script for deploy
  desc "Symlink the upload directories"
  after "deploy:symlink", :roles => [:web] do
    ## create link for shared assets
    # run "#{release_path}/script/relink.sh #{shared_path}/assets #{release_path}/public/images/assets #{previous_release} #{release_name} assets"
    ## create link for mongrel cluster

    # backup_db
    migrate
  end

  # customized tasks
  desc "Backup Mysql"
  task :backup_db, :roles => [:web] do
  run "#{shared_path}/script/mysql_backup.pl NewYouth_production:utf8 #{releases.last} "
  end

  desc "Generate Production database.yml"
  task :database_yml, :roles => [:web] do
    db_config = "#{shared_path}/config/database.yml.production"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end

  desc "Generate Production thin.yml"
  task :thin_yml, :roles => [:web] do
    thin_config = "#{shared_path}/config/thin.yml.production"
    run "cp #{thin_config} #{release_path}/config/thin.yml"
  end

  desc "Generate app_config.yml"
  task :app_config, :roles => [:web] do
    app_config = "#{shared_path}/config/app_config.yml.production"
    run "cp #{app_config} #{release_path}/config/app_config.yml"
  end

  # more info about automatially update and incoporate REASON and UNTIL variable
  # check this out: http://www.letrails.cn/archives/customize-capistrano-maintenance-page
  namespace :web do
    task :disable do
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      maintenance = File.read("./public/maintenance.html")
      put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end

end

# 控制thin
namespace :thin do
  desc "用应用下的config/thin.yml用thin启动应用"
  %w(start stop restart).each do |action|
  desc "#{action} the app's Thin Cluster"
    task action.to_sym, :roles => :app do
      # run "thin #{action} -c #{deploy_to}/current -C #{deploy_to}/current/config/thin.yml"
      run "thin #{action} -C #{shared_path}/config/thin.yml.production"
    end
  end
end

##For testing##

#namespace :develop do
#  desc "Set pre_product ENV"
#  task :settings, :roles => [:pre_product] do
#    set :rails_env,   "development"
#  end
#  desc "Test say hellp"
#  task :hello, :roles => [:pre_product] do
#    run "echo hello"
#  end
  ##run task##
  #########
#end
