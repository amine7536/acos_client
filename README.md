# AcosClient
[![Gem Version](https://badge.fury.io/rb/acos_client.svg)](http://badge.fury.io/rb/acos_client)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acos_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acos_client

## Usage

### Connect

```ruby
require 'acos_client'

c = AcosClient::Client.new('admin', 'a10', '192.168.1.10')
c.session.id
#=> a83d5780ee403f43ff83e46be7a9ff
c.session.close
#=> {:response=>{:status=>"OK"}}
```

### Servers

```ruby
servers = [{
             :name => 'server1.mydns.com',
             :host => '172.16.0.1',
             :port => '80'
         }, {
             :name => 'server2.mydns.com',
             :host => '172.16.0.2',
             :port => '80'
         }]

servers.each do |server|
  puts "Create: #{server}"
  c.slb.server.create(server[:name], server[:host])
  c.slb.server.port.create(server[:name], server[:port], AcosClient::V21::Port::TCP)
end
```

### Service Group

```ruby
c.slb.service_group.create('pool1', 
						   protocol: AcosClient::V21::ServiceGroup::TCP, 
						   lb_method: AcosClient::V21::ServiceGroup::ROUND_ROBIN)

# Add Members 
c.slb.service_group.member.create('pool1', 'server1.mydns.com', '80')
c.slb.service_group.member.create('pool1', 'server2.mydns.com', '80')
```

### Virtual Server
```ruby
c.slb.virtual_server.create('vip1', '172.16.0.10')
```

#### Health Monitor

```ruby
c.slb.hm.create('hm1', AcosClient::V21::HealthMonitor::HTTP, 5, 5, 5, 
				method: 'GET', 
				url: '/', 
				expect_code: '200', 
				port: 80 )

# Update Service Group with HM
c.slb.service_group.update('pool1', health_monitor: 'hm1')
```

### Virtual Service
```ruby
c.slb.virtual_service.create('vs1', 14, 80, '172.16.0.10', 'pool1')

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/acos_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
