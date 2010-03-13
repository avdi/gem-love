require 'link_header'
require 'addressable/uri'

module GemLove

  # A Service collects Notes from Fans and directs them to Gem Authors
  class Service
    attr_reader :notes_url

    def self.notes_relation
      "http://gem-love.avdi.org/relations#notes"
    end

    def initialize(url)
      response   = Net::HTTP.get_response(URI.parse(url))
      links      = LinkHeader.parse(response['Link'].to_s)
      notes_link = links.find_link(["rel", self.class.notes_relation])
      @notes_url = Addressable::URI.parse(notes_link.href)
    end

    def submit_note_from_fan!(note, fan)
      Net::HTTP.post_form(notes_url, 
        :name          => fan.name,
        :email_address => fan.email_address,
        :comment       => note.comment,
        :gem_name      => note.gem_name)
    end
  end
end
