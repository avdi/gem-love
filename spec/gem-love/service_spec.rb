require 'cgi'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module GemLove
  describe Service do
    def parse_form_data(data)
      unencoded_data = CGI.unescape(data)
      pairs          = unencoded_data.split('&')
      pairs.inject({}) {|h, pair|
        name, value = pair.split('=')
        h[name] = value
        h
      }
    end

    before :each do
      stub_request(:get, "example.com").
        to_return(:headers => {
          'Link' => "<http://example.com/notes>; rel=\"#{Service.notes_relation}\""
        })
    end

    subject { Service.new('http://example.com') }

    it "should be able to find the notes resource" do
      subject.notes_url.to_s.should == "http://example.com/notes"
    end

    context "submitting a note" do
      before :each do
        @note = stub("Note", :comment => "COMMENT", :gem_name => "GEMNAME")
        @fan  = stub("Fan", :name => "Tom Servo", :email_address =>  "tom@sol.net")
        stub_request(:post, "example.com/notes")
      end

      def do_submit
        subject.submit_note_from_fan!(@note, @fan)
      end

      it "should submit to the notes resource" do
        do_submit
        WebMock.should have_requested(:post, "example.com/notes")
      end

      it "should submit the fan name to the notes resource" do
        do_submit
        request(:post, "example.com/notes").with do |request|
          parse_form_data(request.body)['name'].should == "Tom Servo"
        end.should have_been_made
      end

      it "should submit the fan email to the notes resource" do
        do_submit
        request(:post, "example.com/notes").with do |request|
          parse_form_data(request.body)['email_address'].should == "tom@sol.net"
        end.should have_been_made
      end

      it "should submit the note text to the notes resource" do
        do_submit
        request(:post, "example.com/notes").with do |request|
          parse_form_data(request.body)['comment'].should == "COMMENT"
        end.should have_been_made
      end

      it "should submit the gem name to the notes resource" do
        do_submit
        request(:post, "example.com/notes").with do |request|
          parse_form_data(request.body)['gem_name'].should == "GEMNAME"
        end.should have_been_made
      end
    end
  end
end
