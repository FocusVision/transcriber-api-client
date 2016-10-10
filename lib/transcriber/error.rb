module Transcriber
  class Error
    def initialize(raw_error)
      @raw_error = raw_error
    end

    def info
      raw_error['detail']
    end

    def code
      raw_error['status']
    end

    private

    attr_reader :raw_error
  end
end
