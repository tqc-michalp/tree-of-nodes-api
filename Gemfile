# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'pg', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0'

gem 'bootsnap', require: false
gem 'data_migrate'
gem 'rack-cors'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0'
end

group :test do
  gem 'database_cleaner-active_record'
end
