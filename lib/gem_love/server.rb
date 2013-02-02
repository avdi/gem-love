require 'sinatra/base'

module GemLove
  class Server < Sinatra::Base
    def initialize(options={})
      super()
      @endorsement_list = options.fetch(:endorsement_list) { Endorsement }
    end

    post '/endorsements/:gem_name' do
      @endorsement_list.add_endorsement_for_gem(params[:gem_name])
    end
  end
end
