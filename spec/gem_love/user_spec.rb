require 'spec_helper'
require 'gem_love/user'

module GemLove
  describe User do
    context "on initialization" do
      subject{ User.new }
      its(:client_key) { should match(/[[:xdigit:]]{32}/) }
    end
  end
end
