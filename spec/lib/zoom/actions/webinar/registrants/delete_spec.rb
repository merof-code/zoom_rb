# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client }
  let(:args) { { webinar_id: 1, registrant_id: 'abcdef' } }

  describe '#webinar_registrant_delete action' do
    before :each do
      stub_request(
        :delete,
        zoom_url("/webinars/#{args[:webinar_id]}/registrants/#{args[:registrant_id]}")
      ).to_return(status: 204, headers: { 'Content-Type' => 'application/json' })
    end

    it "requires a 'webinar_id' and 'registrant_id' argument" do
      expect {
        zc.webinar_registrant_delete(filter_key(args, :webinar_id))
      }.to raise_error(Zoom::ParameterMissing)
      expect {
        zc.webinar_registrant_delete(filter_key(args, :registrant_id))
      }.to raise_error(Zoom::ParameterMissing)
    end

    it 'returns a status code of 204' do
      expect(zc.webinar_registrant_delete(args)).to eq(204)
    end
  end
end
