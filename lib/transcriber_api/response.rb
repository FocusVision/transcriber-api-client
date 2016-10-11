module TranscriberApi
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def id
      data['id'].to_i
    end

    def successful?
      errors.nil?
    end

    def attributes
      data ? data['attributes'] : []
    end

    def error
      successful? ? nil : TranscriberApi::Error.new(json['errors'])
    end

    def data
      json['data']
    end

    def errors
      json['errors']
    end

    private

    attr_reader :raw_response

    def json
      @json ||= JSON.parse(raw_response.body)
    end
  end
end
