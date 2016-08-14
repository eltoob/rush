require 'httparty'

module Rush
  class Delivery
    attr_accessor :client, :items, :pickup, :dropoff
    def initialize(opts)
      @client = opts[:client]
      @items = opts[:items]
      @pickup = opts[:pickup]
      @dropoff = opts[:dropoff]
    end

    def quote
      response = HTTParty.post("#{client.api_uri}deliveries/quote")
      if response.success?
      else
        raise response.body
      end
      return response
    end

    def find
    end

    def find_all
    end


  end
end
