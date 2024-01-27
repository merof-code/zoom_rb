# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do
  let(:zc) { zoom_client }

  describe '#user_zak action' do
    context 'with a valid response' do
      before :each do
        stub_request(
          :get,
          zoom_url("/users/me/zak")
        ).to_return(status: 200,
                    body: json_response('user', 'zak'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a users zak token' do
        res = zc.user_zak
        expected_response = JSON.parse(json_response('user', 'zak'))
        expect(res['token']).to eq(expected_response['token'])
      end
    end
  end
end
