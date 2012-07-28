# Shellfish

Solve problem, learn shell commands.

## Installation

Add this line to your application's Gemfile:

    gem 'shellfish'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shellfish

## Usage

    $ shellfish PROBLEM_DEFINITION_FILE [...]

## Writing Problem Definition File

It's can be written with DSL.

```ruby
subject "Subject of the problem"
desc "Description of the problem"
expected "Expected output"
```

Expected result can be written also using `__END__`

```ruby
subject "Subject of the problem"
desc "Description of the problem"

__END__
Expected output
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
