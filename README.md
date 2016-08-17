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


### Authentication
```ruby
Rush.configure do |config|
  config.client_secret = "client_secret"
  config.client_id = "client_id"
  config.server_token = "server_token"
  config.sandbox = true
end
```
### Fetch deliveries
```ruby
client = Rush::Client.new
client.fetch_deliveries
```
### Get a quote

### Order a delivery
```ruby
client = Rush::Client.new
client.fetch_deliveries

location = { address: '636 w 28th street',
             city: 'New York',
             state: 'NY',
             postal_code: '10014',
             country: 'US'}
contact = {
  first_name: 'Tester',
  last_name: 'Mctestie',
  phone: {number: '+14214214211'}
}

signature_required = false
pickup = Rush::PickUp.new(location: location, contact: contact, signature_required: signature_required)
dropoff = Rush::DropOff.new(location: location, contact: contact, signature_required: signature_required)
items = [{title: 'Chocolate bar', quantity: 1, is_fragile: true}]
client.create_delivery(items, pickup, dropoff)
    location = { address: '64 Seabring St',
             city: 'Brooklyn',
             state: 'NY',
             postal_code: '11231',
             country: 'US'}
    contact = {
      first_name: 'tester',
      last_name: 'Mctestie',
      phone: {number: '+14214214211'}
    }
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eltoob/rush.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
