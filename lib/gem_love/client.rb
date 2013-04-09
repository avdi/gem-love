require 'net/http'
module GemLove
  class Client
    attr_reader :client_key

    def initialize(options={})
      @client_key = options.fetch(:client_key) {
        ENV.fetch('GEMLOVE_CLIENT_KEY') {
          "NO_KEY_FOUND"
        }
      }
    end

    def endorse_gem(gem_name)
      url = URI("http://www.gemlove.org/endorsements/#{gem_name}")
      request = Net::HTTP::Post.new(url.path)
      request['Authentication'] = "Bearer #{client_key}"
      result = Net::HTTP.start(url.host, url.port) do |http|
        http.request(request)
      end
    end
  end
end
