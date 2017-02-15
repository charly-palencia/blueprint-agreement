module BlueprintAgreement
  class Configuration
    attr_accessor :exclude_attributes,
      :allow_headers,
      :port,
      :hostname,
      :root_path,
      :service

    def initialize
      @exclude_attributes = nil
      @allow_headers = nil
      @port = "8082"
      @hostname = "http://localhost"
      @root_path = '.'
      @service = :drakov
    end

    def allow_headers=(headers)
      @allow_headers = headers.map { |header| "--header #{header}" }.join(" ")
    end
  end
end
