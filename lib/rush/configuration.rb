module Rush
  module Configuration
    VALID_CONNECTION_KEYS = [:client_secret, :client_id, :sandbox, :access_token].freeze
    DEFAULT_CLIENT_SECRET = nil
    DEFAULT_CLIENT_ID = nil
    DEFAULT_SANDBOX = true
    API_SANDBOX_URI = 'https://sandbox-api.uber.com/v1/'
    API_PRODUCTION_URI = 'https://api.uber.com/v1/'

    attr_accessor *VALID_CONNECTION_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.client_secret = DEFAULT_CLIENT_SECRET
      self.client_id = DEFAULT_CLIENT_ID
      self.sandbox = DEFAULT_SANDBOX
    end

    def options
      {}.tap do |symbol_options|
        _raw_options.each do |key, value|
          symbol_options[key.to_sym] = value
        end
      end
    end

    private

    def _raw_options
      Hash[ * VALID_CONNECTION_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
