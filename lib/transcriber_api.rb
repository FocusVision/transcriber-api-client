require 'httparty'
require 'transcriber_api/constants'
require 'transcriber_api/exceptions'
require 'transcriber_api/configuration'
require 'transcriber_api/response'
require 'transcriber_api/client'
require 'transcriber_api/transcript_request'
require 'transcriber_api/version'

module TranscriberAPI
  BASE_URI = 'https://www.24tru.com'.freeze

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield configuration
  end
end
