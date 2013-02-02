require_relative '../../lib/gem_love/server'
require 'rack/test'

module GemLove
  describe Server do
    describe "receiving a gem endorsement" do
      it "records a new endorsement for the given gem" do
        endorsement_list = double
        server  = GemLove::Server.new(endorsement_list: endorsement_list)
        browser = Rack::Test::Session.new(Rack::MockSession.new(server))

        endorsement_list.should_receive(:add_endorsement_for_gem).with('fattr')
        browser.post('/endorsements/fattr')
      end
    end
  end
end
