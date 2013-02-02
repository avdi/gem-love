require 'rubygems/commands/love_command.rb'
require 'webmock/rspec'

module GemLove
  describe GemUser do
    describe '#endorse_gem' do
      it 'registers a gem endorsement with the gem-love server' do
        gem_user = GemUser.new
        stub_request(:any, 'www.gemlove.org/endorsements/fattr')
        gem_user.endorse_gem("fattr")
        a_request(:post, 'www.gemlove.org/endorsements/fattr').
          should have_been_made
      end
    end
  end
end
