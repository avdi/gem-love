require 'data_mapper'
require 'securerandom'
module GemLove
  class User
    include DataMapper::Resource

    property :login, String, key: true
    property :client_key, String,
    length: 32,
    default: ->(*){ SecureRandom.hex(16) }

    def self.for_client_key(key)
      first(client_key: key)
    end

  end
end
