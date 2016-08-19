require 'httparty'
module Rush

  class Client

    OAUTH_URI = 'https://login.uber.com/oauth/v2/token'
    attr_accessor *Configuration::VALID_CONNECTION_KEYS

    def initialize(options={})
      merged_options = Rush.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONNECTION_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      get_access_token

    end

    def api_uri
      sandbox ? Configuration::API_SANDBOX_URI : Configuration::API_PRODUCTION_URI
    end

    def get_access_token
      return self if access_token
      data = {client_secret: client_secret,
              client_id: client_id,
              server_token: server_token,
              grant_type: 'client_credentials',
              scope: sandbox ? 'delivery_sandbox' : ''
      }
      response = HTTParty.post(OAUTH_URI, body: data)
      if response.success?
        self.access_token = JSON.parse(response.body)["access_token"]
        return self.access_token
      else
        raise "Could not retrieve access token: #{response.body}"
      end

    end

    def create_delivery(items, pickup, dropoff, quote_id=nil)
      body = {items: items, pickup: pickup.to_json, dropoff: dropoff.to_json}.to_json
      response = HTTParty.post(api_uri + 'deliveries', body: body, headers: { "Authorization" => "Bearer #{access_token}",
                                                                              'Content-Type' => 'application/json'})
      if response.success?
        return response.parsed_response
      else
        raise(response.parsed_response)
      end
    end

    def get_quotes(pickup, dropoff)
      body = {pickup: pickup, dropoff: dropoff}
      response = HTTParty.post(api_uri + 'deliveries/quote', body: body, headers: { "Authorization" => "Bearer #{access_token}"})
    end

    def fetch_deliveries(offset=0)
      response = HTTParty.get(api_uri + 'deliveries?offset=' + offset.to_s, headers: { "Authorization" => "Bearer #{access_token}"})
      # Transforms json into a hash
      result = response.parsed_response["deliveries"].map {|p| p.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}}

      return result.map{|s| Delivery.new(s)}
    end

    def find_delivery(id)
      response = HTTParty.get(api_uri + 'deliveries/' + id.to_s, headers: { "Authorization" => "Bearer #{access_token}"})
      # Transforms json into a hash
      result = response.parsed_response.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      return Delivery.new(result)

    end
  end
end
