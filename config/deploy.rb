set :application, "token_auth"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"
set :user, "thub"
set :runner,nil
set :use_sudo, true
default_run_options[:pty] = true 

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :scm, :git
set :repository, "ssh://thub@trustrelay.com/home/thub/work/token_auth"
set :branch, "master"

role :app, "www.thubhub.com"
role :web, "www.thubhub.com"
role :db,  "www.thubhub.com", :primary => true
