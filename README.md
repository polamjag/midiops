# MIDIOps

[![Gem Version](https://badge.fury.io/rb/midiops.svg)](https://rubygems.org/gems/midiops)
[![Circle CI](https://circleci.com/gh/polamjag/midiops.svg?style=svg)](https://circleci.com/gh/polamjag/midiops)

MIDI Operations. Heavily inspired by [this blog entry](http://hitode909.hatenablog.com/entry/2015/07/28/134304) and [hitode909/sketch-midi](https://github.com/hitode909/sketch-midi).

## Installation

[MIDIOps is available on Rubygems](https://rubygems.org/gems/midiops).

Add this line to your application's Gemfile:

```ruby
gem 'midiops'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install midiops

## Usage

This is a super simple example:

```ruby
require 'midiops'

observer = MIDIOps::Observer.new

# args: midi ch, note in string
observer.on_key 0, 'C5' do
  puts "Ch.0.C5 pressed!"
end

observer.on_key 0, 'D5' do |vel|
  puts "Ch.0.C5 pressed with velocity #{vel}!"
end

observer.listen_first
```

Connect some MIDI keyboard and execute the script, then press key C5 or D5 on your midi device. Hooray!

See `/examples` for more materials.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/polamjag/midiops. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
