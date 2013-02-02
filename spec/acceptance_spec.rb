require 'spec_helper'
require 'gem_love'
require 'shellwords'
require 'data_mapper'
require 'webmock/rspec'

module GemLove
  def self.gem_named(name)
    Rubygem.get(name)
  end

  Rubygem = Struct.new(:name) do
    def self.get(name)
      new(name)
    end

    def endorsements
      endorsement_list.all_for_gem_named(name)
    end

    def endorsement_list
      Endorsement
    end
  end
end

describe 'gem love command', db: true do
  specify 'endorsing a gem' do
    stub_request(:any, /^www\.gemlove\.org/).to_rack(GemLove::Server)
    run 'gem love fattr'
    gem_named('fattr').should have(1).endorsements
  end

  def run(shell_command)
    args = shell_command.sub(/^gem love /, '').shellsplit
    command = Gem::Commands::LoveCommand.new
    command.invoke(*args)
  end

  def gem_named(name)
    GemLove.gem_named(name)
  end
end
