require 'spec_helper'

describe Rush do
  describe 'delivery' do

    describe "new" do
      it 'sets up the right values' do
        delivery = Rush::Delivery.new(client: 1, items: 2, pickup: 3, dropoff: 4)
        expect(delivery.client).to eq 1
        expect(delivery.items).to eq 2
        expect(delivery.pickup).to eq 3
        expect(delivery.dropoff).to eq 4
      end
    end

    describe "quote" do
      it 'sends a request to quote the delivery and returns the correct value' do
        skip
        client = Rush::Client.new(client_id: "PVHwWxeFnsR-BsSr3BkqDYJNzSj6zTeo", client_secret: "I8-1rOtKfz7iB0YV2Zzm7ZT13PHk2U0i74CFHDMz", sandbox: true)
        delivery = Rush::Delivery.new(client: client, items: 2, pickup: 3, dropoff: 4)
        delivery.quote
      end
    end
  end
end
