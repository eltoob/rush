# Ruby wrapper around uber rush api

The goal of this gem is to provide a layer of abstraction for the Uber Rush API.
For more information about the Rush API, please visit: https://developer.uber.com/docs/rush

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rush'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rush

## Usage

### Configuration
```ruby
Rush.configure do |config|
  config.client_id = "client_id"
  config.client_secret = "client_secret"
  config.server_token = "server_token"
  config.sandbox = true
end
```

### Read Access Token

> You can authenticate as your application using the `client_credentials` grant type. This will create an OAuth 2.0 access token with the specified scopes. These tokens cannot be refreshed, but they can be created as many times as needed (e.g., for each server/thread or when they expire). [(more info)](https://developer.uber.com/docs/deliveries/guides/authentication#client-credentials-flow)

```ruby
client = Rush::Client.new # Authenticates on initialize
client.get_access_token # does not generate a new token
```

### Fetch Deliveries

> Get a list of all deliveries, ordered chronologically by time of creation. [(more info)](https://developer.uber.com/docs/deliveries/references/api/v1-deliveries-get)

```ruby
client.fetch_deliveries
# => List of Delivery objects
```

### Get a Quote and Order a Delivery

First, you need to setup a `Rush::PickUp` and `Rush::DropOff` with some location and contact information:

```ruby
pickup_location = { address: '636 w 28th street',
  city: 'New York',
  state: 'NY',
  postal_code: '10014',
  country: 'US'
}
pickup_contact = {
  first_name: 'Tester',
  last_name: 'Mctestie',
  phone: {number: '+14214214211'}
}

dropoff_location = { address: '64 Seabring St',
  city: 'Brooklyn',
  state: 'NY',
  postal_code: '11231',
  country: 'US'
}
dropoff_contact = {
  first_name: 'tester dropoff',
  last_name: 'Mctestie',
  phone: {number: '+14214214211'}
}

pickup = Rush::PickUp.new(location: pickup_location, contact: pickup_contact, signature_required: false)
dropoff = Rush::DropOff.new(location: dropoff_location, contact: dropoff_contact, signature_required: false)
```
Now, we can get a quote or create a delivery:

#### Get a Quote
> Generate a delivery quote, given a pickup and dropoff location. On-demand and scheduled delivery quotes will be returned. [(more info)](https://developer.uber.com/docs/deliveries/references/api/v1-deliveries-quote-post)

```ruby
client.get_quotes(pickup, dropoff)
# => List of quote hashes
```

#### Create a Delivery

> The Delivery endpoint allows a delivery to be requested given the delivery information and quote ID. [(more info)](https://developer.uber.com/docs/deliveries/references/api/v1-deliveries-post)

```ruby
items = [
    {
      title: 'Chocolate bar',
      quantity: 1,
      is_fragile: true
    }
  ]
client.create_delivery(items, pickup, dropoff)
# => Delivery Hash
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eltoob/rush.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
