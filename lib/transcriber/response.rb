module Transcriber
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def id
      data['id'].to_i
    end

    def successful?
      error_code.zero?
    end

    def attributes
      data ? data['attributes'] : []
    end

    def error
      successful? ? nil : @raw_response['errors']['detail']
    end

    def error_code
      @raw_response['errors'] ? @raw_response['errors']['status'].to_i : 0
    end

    def data
      @raw_response['data']
    end
  end
end
