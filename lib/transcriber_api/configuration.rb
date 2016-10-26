module TranscriberAPI
  class Configuration
    attr_accessor :api_key
    attr_writer :__base_uri__

    def __base_uri__
      @__base_uri__ || BASE_URI
    end
  end
end
