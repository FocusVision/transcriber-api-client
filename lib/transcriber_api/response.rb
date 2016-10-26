module TranscriberAPI
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def successful?
      raw_response.success?
    end

    def data
      json['data']
    end

    def id
      data['id'].to_i
    end

    def attributes
      data ? data['attributes'] : []
    end

    def errors
      Array(json['errors']).map { |error| Error.from_raw(error) }
    end

    private

    attr_reader :raw_response

    def json
      @json ||= JSON.parse(raw_response.body)
    end
  end
end
