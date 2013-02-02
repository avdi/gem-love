$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

begin
  # use `bundle install --standalone' to get this...
  require_relative '../bundle/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end

RSpec.configure do |config|
  config.before(:each, db: true) do
    DataMapper.setup(:default, 'sqlite::memory:')
    DataMapper.auto_migrate!
  end
end
