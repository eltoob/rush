require 'spec_helper'

describe Rush do
  describe "configuration" do
    describe "client_secret" do
      it 'returns the default client_secret' do
        expect(Rush.client_secret).to eq Rush::Configuration::DEFAULT_CLIENT_SECRET
      end
    end

    describe "client_id" do
      it 'returns the default client id' do
        expect(Rush.client_id).to eq Rush::Configuration::DEFAULT_CLIENT_ID
      end
    end

    describe "sandbox" do
      it 'returns the default sandbox option (true)' do
        expect(Rush.sandbox).to eq true
      end
    end

    describe "configration_call" do
      it 'sets the right values for the configuration file' do
        Rush.configure do |config|
          config.client_id = "client_id"
          config.client_secret = "client_secret"
          config.sandbox = true
        end

        expect(Rush.client_id).to eq "client_id"
        expect(Rush.client_secret).to eq "client_secret"
        expect(Rush.sandbox).to eq true
      end
    end
  end
end
