source 'http://ruby.taobao.org'
ruby '1.9.3'
gem 'rails', '3.2.8'
gem 'mysql2'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'rolify'
gem 'simple_form'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'capistrano-recipes'
  gem 'capistrano-helpers'
  gem 'capistrano-unicorn',:git=>'git://github.com/sosedoff/capistrano-unicorn.git'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
end
group :production do
  gem 'unicorn'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end

gem 'typhoeus'
gem 'nokogiri'

gem "ransack", :git => "git://github.com/ernie/ransack.git"
gem 'enumerize'
gem 'kaminari'
gem 'breadcrumbs'
gem 'RedCloth'
