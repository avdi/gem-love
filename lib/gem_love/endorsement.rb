require 'data_mapper'
require 'gem_love/user'
module GemLove
  class Endorsement
    include DataMapper::Resource

    property :gem_name, String, key: true

    belongs_to :user

    def self.all_for_gem_named(name)
      all(gem_name: name)
    end

    def self.add_endorsement_for_gem_by_client_key(gem_name, client_key)
      user = user_list.for_client_key(client_key)
      create(gem_name: gem_name, user: user)
    end

    def self.by_login(login)
      all(user: {login: login})
    end

    def self.user_list
      User
    end
  end
end
