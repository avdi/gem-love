require 'data_mapper'
module GemLove
  class Endorsement
    include DataMapper::Resource

    property :gem_name, String, key: true

    def self.all_for_gem_named(name)
      all(gem_name: name)
    end

    def self.add_endorsement_for_gem(gem_name)
      create(gem_name: gem_name)
    end
  end
end
