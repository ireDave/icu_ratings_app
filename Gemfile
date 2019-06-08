source "http://rubygems.org"

gem "rails", "4.2.5"
gem "sprockets", "2.12.3" # Latest version of sprockets 2.*. 3.* causes a failure at startup
gem "mysql2"
gem "icu_tournament", "1.9.7"
gem "icu_utils", "1.3.2"
gem "icu_ratings"
gem "icu_name", "1.2.6"
gem "whenever", :require => false
gem "redcarpet"
gem "nokogiri"
gem "cancan", "~> 1.6"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "rack-mini-profiler"
gem "haml-rails"
gem "sass-rails", "~> 5.0"
gem "coffee-rails", "~> 4.1.0"
gem "therubyracer", platforms: :ruby
gem "uglifier"
gem "jbuilder"
gem "puma"

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-nvm',     require: false
  # Include capistrano-ssh-doctor to check for ssh errors running capistrano
  # gem 'capistrano-ssh-doctor', '~> 1.0'
  gem "wirble"
end

group :test, :development do
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "launchy"
  gem "factory_girl_rails"
  gem "faker"
  gem "database_cleaner"
  #gem "byebug"
end
