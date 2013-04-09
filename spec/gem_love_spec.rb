require 'spec_helper'
require 'gem_love'

module GemLove
  describe GemLove do
    describe '.add_endorsement_for_gem_by_client_key', db: true  do
      it 'records a new endorsement' do
        user      = double(login: 'avdi').as_null_object
        User.stub(:for_client_key).with('abc123').and_return(user)
        expect {
          GemLove.add_endorsement_for_gem_by_client_key('mygem', 'abc123')
        }.to change{Endorsement.all_for_gem_named('mygem').count}.by(1)
      end

      it 'associates the new endorsement with the key-specified user' do
        user      = double(login: 'avdi').as_null_object
        User.stub(:for_client_key).with('abc123').and_return(user)
        endorsement = GemLove.add_endorsement_for_gem_by_client_key(
          'mygem', 'abc123')
        endorsement.user_login.should eq('avdi')
      end
    end
  end
end
