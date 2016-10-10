
require 'httparty'
require 'transcriber/error'
require 'transcriber/configuration'
require 'transcriber/response'
require 'transcriber/client'
require 'transcriber/version'

module Transcriber
  BASE_URI = 'https://www.24tru.com/r/api'.freeze

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield configuration
  end
end
