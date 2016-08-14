require 'spec_helper'

describe Rush do
  describe 'client' do
    describe "api_uri" do
      xit 'sets the right api uri' do
        client = Rush::Client.new(sandbox: true)
        expect(client.api_uri).to eq "https://sandbox-api.uber.com/v1/"
      end
    end
  end
end

