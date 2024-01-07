# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { meeting_id: 1 } }

  describe '#meeting_survey action' do
    before :each do
      stub_request(
        :get,
        zoom_url("/meetings/#{args[:meeting_id]}/survey")
      ).to_return(body: json_response('meeting', 'get_survey'), headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns a hash' do
      expect(zc.meeting_survey(args)).to be_kind_of(Hash)
    end

    it "returns survey properties" do
      expect(zc.meeting_survey(args)['show_in_the_browser']).to eql(true)
    end
  end
end
