# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { meeting_id: 1, registrant_id: 'abcdef' } }

  describe '#meeting_delete_registrant action' do
    before :each do
      stub_request(
        :delete,
        zoom_url("/meetings/#{args[:meeting_id]}/registrants/#{args[:registrant_id]}")
      ).to_return(status: 204, headers: { 'Content-Type' => 'application/json' })
    end

    it "requires a 'meeting_id' and 'registrant_id' argument" do
      expect {
        zc.meeting_delete_registrant(filter_key(args, :meeting_id))
      }.to raise_error(Zoom::ParameterMissing)
      expect {
        zc.meeting_delete_registrant(filter_key(args, :registrant_id))
      }.to raise_error(Zoom::ParameterMissing)
    end

    it 'returns a status code of 204' do
      expect(zc.meeting_delete_registrant(args)).to eq(204)
    end
  end
end
