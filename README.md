# TranscriberAPI::Client

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
TranscriberAPI::Client#create

# GET request to the API to retrieve a transcript request
TranscriberAPI::Client#find

# PATCH request to the API to cancel a transcript request
TranscriberAPI::Client#cancel

# PATCH request to the API to add the audio file to a transcript request
TranscriberAPI::Client#add_media

# PATCH request to the API to update expected_media_date a transcript request
TranscriberAPI::Client#update
```

Example:
```ruby
client = TranscriberAPI::Client.new
response = client.update(99, expected_media_date: Time.now + 1.day)
response.successful?
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
