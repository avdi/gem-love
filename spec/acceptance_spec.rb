require 'spec_helper'
require 'gem_love'
require 'shellwords'
require 'data_mapper'
require 'webmock/rspec'

describe 'gem love command', db: true do
  before do
    ENV.delete('GEMLOVE_CLIENT_KEY')
  end

  specify 'endorsing a gem' do
    stub_request(:any, /^www\.gemlove\.org/).to_rack(GemLove::Server)
    make_confirmed_user 'avdi'
    make_confirmed_user 'ylva'
    set_client_user 'avdi'
    gem_named('fattr').should_not be_endorsed_by('avdi')
    run 'gem love fattr'
    gem_named('fattr').should be_endorsed_by('avdi')
    gem_named('fattr').should_not be_endorsed_by('ylva')
  end

  def make_confirmed_user(login)
    user = GemLove.create_user(login)
    raise "Unable to create user #{login}" unless user.saved?
  end

  def set_client_user(login)
    user = GemLove.user_for_login(login)
    @client_key = user.client_key
  end

  def run(shell_command)
    args = shell_command.sub(/^gem love /, '').shellsplit
    command = Gem::Commands::LoveCommand.new
    ENV['GEMLOVE_CLIENT_KEY'] = @client_key if @client_key
    command.invoke(*args)
  end

  def gem_named(name)
    GemLove.gem_named(name)
  end
end
