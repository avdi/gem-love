require 'spec_helper'
require 'gem_love/server'
require 'rack/test'

module GemLove
  describe Server do
    describe "receiving a gem endorsement" do
      it "records a new endorsement for the given gem" do
        endorsement_list = double
        server  = GemLove::Server.new(endorsement_list: endorsement_list)
        browser = Rack::Test::Session.new(Rack::MockSession.new(server))

        endorsement_list.should_receive(:add_endorsement_for_gem_by_client_key).
          with('fattr', 'SOME_CLIENT_KEY')
        browser.post('/endorsements/fattr', {},
          {'HTTP_AUTHENTICATION' => 'Bearer SOME_CLIENT_KEY'})
      end
    end
  end
end
