require 'spec_helper'

describe Rush do
  describe 'client' do
    describe "api_uri" do
      xit 'sets the right api uri' do
        client = Rush::Client.new(sandbox: true)
        expect(client.api_uri).to eq "https://sandbox-api.uber.com/v1/"
      end

      it "overrides the default configuration" do
        Rush.configure do |config|
          config.client_id = "client_id"
          config.sandbox = true
          config.access_token = "access_token"
        end
        client = Rush::Client.new(client_id: "other_client_id")

        expect(client.client_id).to eq "other_client_id"
      end
    end
  end
end

