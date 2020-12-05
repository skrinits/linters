# Linters

Linters is a tool which checks ruby applications using different code's analyzers.
Default available analyzers are:
* rubocop
* reek
* brakeman
* bundle-audit
* fasterer

## Installation

* Using RubyGems:

  ```gem install linters```

  Install the linters which you want to use:

  ```gem install rubocop reek and etc...```

* Using Bundler:

  ```ruby
  group :development do
    gem 'linters'
  end
  ```

  Add linters which you want to use:
  ```ruby
    group :development do
      gem 'rubocop'
      gem 'reek'
      and etc...
    end
  ```

And then execute:

  $ bundle

## Usage

### Configuration

Settings with default values:

```ruby
  Linters.configure do |config|
    config.custom_linters = {}
    config.linters = %i[rubocop reek bundle_audit fasterer]
    config.settings_path = 'config/settings.yml'
  end
```

Default config/settings.yml:

```
rubocop:
  warnings_number: 0
reek:
  warnings_number: 0
bundle_audit:
  warnings_number: 0
fasterer:
  warnings_number: 0
```

If settings is absent that warnings_number equal zero.

### Adding a customer linter
```ruby
  Linters.configure do |config|
    config.custom_linters = {
      name: {
        command: 'execute command',
        parse_output: 'parse output of the command for getting quantity of warnings'
      }
    }
  end
```

### Rewrite an available linter
```ruby
  Linters.configure do |config|
    config.custom_linters = {
      rubocop: {
        command: 'your command',
        parse_output: 'your parsing output'
      }
    }
  end
```

### Run a check
* Run all linters
```
  rake linters:run_all
```
* Run a specific linter
```
  rake linters:run[name of linter]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skrinits/linters.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
