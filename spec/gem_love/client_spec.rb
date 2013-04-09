require 'gem_love/client'
require 'webmock/rspec'

module GemLove
  describe Client do
    describe '#endorse_gem' do
      it 'registers a gem endorsement with the gem-love server' do
        gem_user = Client.new
        stub_request(:any, 'www.gemlove.org/endorsements/fattr')
        gem_user.endorse_gem("fattr")
        a_request(:post, 'www.gemlove.org/endorsements/fattr').
          should have_been_made
      end

      it 'includes the client key in requests' do
        gem_user = Client.new(client_key: "THE_CLIENT_KEY")
        stub_request(:any, 'www.gemlove.org/endorsements/nulldb')
        gem_user.endorse_gem("nulldb")
        a_request(:post, 'www.gemlove.org/endorsements/nulldb').
          with(headers: {'Authentication' => 'Bearer THE_CLIENT_KEY' }).
          should have_been_made
      end
    end
  end
end
