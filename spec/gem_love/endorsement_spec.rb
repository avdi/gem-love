require 'spec_helper'
require 'gem_love/endorsement'

module GemLove
  describe Endorsement do
    describe '.add_endorsement_for_gem', db: true  do
      it 'records a new endorsement' do
        expect {
          Endorsement.add_endorsement_for_gem('mygem')
        }.to change{Endorsement.all_for_gem_named('mygem').count}.by(1)
      end
    end
  end
end
