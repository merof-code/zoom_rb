require 'spec_helper'

describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client }
  let(:args) { { webinar_id: '123456789' } }

  describe '#past_webinars_participants' do
    context 'with a valid response' do
      before :each do
        stub_request(
          :get,
          zoom_url("/past_webinars/#{args[:webinar_id]}/participants")
        ).to_return(status: 200,
                    body: json_response('webinar', 'past_webinars_participants'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it "requires a 'webinar_id' argument" do
        expect { zc.past_webinars_participants(filter_key(args, :webinar_id)) }.to raise_error(Zoom::ParameterMissing, [:webinar_id].to_s)
      end

      it 'returns a webinar instance with participants as an array' do
        expect(zc.past_webinars_participants(args)['participants']).to be_kind_of(Array)
      end
    end

    context 'with a 4xx response' do
      before :each do
        stub_request(
          :get,
          zoom_url("/past_webinars/#{args[:webinar_id]}/participants")
        ).to_return(status: 404,
                    body: json_response('error', 'validation'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'raises Zoom::Error exception' do
        expect { zc.past_webinars_participants(args) }.to raise_error(Zoom::Error)
      end
    end
  end
end
