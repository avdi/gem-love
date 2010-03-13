require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'construct'

module GemLove
  describe Fan do
    include Construct::Helpers

    before :each do
      @construct = create_construct
      @ui = stub("UI")
      @ui.stub(:ask).with(/name/).and_return("Tom Servo")
      @ui.stub(:ask).with(/email/).and_return("tom@sol.net")
    end

    after :each do
      @construct.destroy!
    end

    context "initialized with no saved user info" do
      it "should prompt for name and email address" do
        @ui.should_receive(:ask).with(/name/).
          and_return("Tom Servo")
        @ui.should_receive(:ask).with(/email/).
          and_return("tom@sol.net")
        fan = Fan.load_or_init(@ui, :home_dir => @construct)
      end

    end

    context "for a fresh user" do
      subject { Fan.load_or_init(@ui, :home_dir => @construct) }

      it "should have the entered name" do
        subject.name.should == "Tom Servo"
      end

      it "should have the entered email" do
        subject.email_address.should == "tom@sol.net"
      end

      it "should save the entered name" do
        subject                 # force init
        saved_fan = YAML.load_file((@construct + '.gem' + 'love.yml').to_s)
        saved_fan.name.should == "Tom Servo"
      end

      it "should save the entered email" do
        subject                 # force init
        saved_fan = YAML.load_file((@construct + '.gem' + 'love.yml').to_s)
        saved_fan.email_address.should == "tom@sol.net"
      end
    end

    context "for a saved user" do
      subject { Fan.load_or_init(@ui, :home_dir => @construct) }

      before :each do
        @construct.file ".gem/love.yml" do |f|
          fan = Fan.new("Crow T Robot", "crow@sol.net")
          YAML.dump(fan, f)
        end
      end

      it "should not prompt the user on init" do
        @ui.should_not_receive(:ask)
        Fan.load_or_init(@ui, :home_dir => @construct)
      end

      it "should have the saved name" do
        subject.name.should == "Crow T Robot"
      end

      it "should have the saved email address" do
        subject.email_address.should == "crow@sol.net"
      end
    end

  end
end
