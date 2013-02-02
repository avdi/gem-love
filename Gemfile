# A sample Gemfile
source "https://rubygems.org"

group 'test' do
  gem 'rake',                   '~> 10.0'
  gem 'rspec',                  '~> 2.12'
  gem 'webmock',                '~> 1.8'
  gem 'rack-test',              '~> 0.6.2'
  gem 'dm-sqlite-adapteer',     '~> 1.2'
end

group 'server' do
  gem 'sinatra',                '~> 1.3'
end

group 'test', 'server' do
  gem 'data_mapper',            '~> 1.2'
end
