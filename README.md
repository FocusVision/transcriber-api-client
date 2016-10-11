# TranscriberApi::Client

A client for the FV transcription API  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transcriber-api-client'
```

And then execute:

    $ bundle

## Usage

The following methods are implemented:

```ruby
# POST request to the API to create a transcript requests
TranscriberApi::Client#create

# GET request to the API to retrieve a transcript request
TranscriberApi::Client#find

# PATCH request to the API to cancel a transcript request
TranscriberApi::Client#cancel

# PATCH request to the API to add the audio file to a transcript request
TranscriberApi::Client#add_media

# PATCH request to the API to update expected_media_date a transcript request
TranscriberApi::Client#update
```

Example:
```ruby
client = TranscriberApi::Client.new
response = client.update(99, expected_media_date: Time.now + 1.day)
response.successful?
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
