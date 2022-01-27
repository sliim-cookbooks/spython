source 'https://rubygems.org'

gem 'chef', "~> #{ENV['CHEF_VERSION'] || 14}"
gem 'berkshelf'
gem 'rake'

group :development do
  gem 'guard'
  gem 'guard-rubocop'
end

group :kitchen do
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
  gem 'kitchen-inspec'
  gem 'test-kitchen'
end

group :lint do
  gem 'cookstyle'
end
