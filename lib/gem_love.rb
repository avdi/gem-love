require 'rubygems/command'
require 'rubygems/commands/love_command'
require 'gem_love/endorsement'
require 'gem_love/server'
require 'gem_love/user'
require 'gem_love/client'

module GemLove
  def self.gem_named(name)
    Rubygem.get(name)
  end

  def self.create_user(login)
    User.create(login: login)
  end

  def self.user_for_login(login)
    User.get(login)
  end

  def self.add_endorsement_for_gem_by_client_key(gem_name, client_key)
    user = User.for_client_key(client_key)
    Endorsement.create(gem_name: gem_name, user: user)
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

    def endorsed_by?(login)
      endorsements.by_login(login).any?
    end
  end
end
