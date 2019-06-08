# Load DSL and setup stages
require 'capistrano/setup'
require 'capistrano/deploy'
require 'whenever/capistrano'
# Use ssh_doctor to check if you can reach the machine and run commands on it.
# require 'capistrano/ssh_doctor'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/nvm'

# Load custom tasks from `lib/capistrano/tasks'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
