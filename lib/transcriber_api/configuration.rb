module TranscriberAPI
  class Configuration
    attr_accessor :api_key, :__base_uri__, :__verify_ssl__

    def initialize
      @__base_uri__ = BASE_URI
      @__verify_ssl__ = true
    end
  end
end
