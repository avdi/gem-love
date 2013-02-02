RSpec.configure do |config|
  config.before(:each, db: true) do
    DataMapper.setup(:default, 'sqlite::memory:')
    DataMapper.auto_migrate!
  end
end
