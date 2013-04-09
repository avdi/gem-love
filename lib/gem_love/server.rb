require 'sinatra/base'

module GemLove
  class Server < Sinatra::Base
    def initialize(options={})
      super()
      @gem_love = options.fetch(:gem_love) { GemLove }
    end

    post '/endorsements/:gem_name' do
      client_key = env['HTTP_AUTHENTICATION'][/Bearer (\w+)/,1]
      @gem_love.add_endorsement_for_gem_by_client_key(
        params[:gem_name],
        client_key)
    end
  end
end
