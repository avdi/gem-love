require 'rubygems/command'
class Gem::Commands::LoveCommand < Gem::Command
  def initialize
    super 'love', 'Tell the world of your love for a gem'
  end

  def arguments
    "GEM_NAME           the name of the gem you wish to endorse"
  end

  def usage
    "#{program_name} GEM_NAME"
  end

  def description
    <<END
Records your appreciation for a gem on gemlove.org.
END
  end

  def execute
    gem_name = get_one_gem_name
    gem_user = GemLove::GemUser.new
    gem_user.endorse_gem(gem_name)
  end
end

require 'net/http'
module GemLove
  class GemUser
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
