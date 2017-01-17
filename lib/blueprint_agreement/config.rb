module BlueprintAgreement
  module Config
    extend self
    @@exclude_attributes = nil
    @@allow_headers = nil
    @@port = "8082"
    @@hostname = "http://localhost"
    @@api_service = APIServices::Drakov

    def configure; yield self end

    def port=(port)
      @@port = port
    end

    def server_path=(server_path)
      @server_path = server_path
    end

    def exclude_attributes=(exclude_attributes)
      @@exclude_attributes = exclude_attributes
    end

    def api_service?
      !!@@api_service
    end

    def api_service=(service)
      @@api_service = case service
                      when :drakov
                        APIServices::Drakov
                      else
                        raise "Service #{service} not available"
                      end
    end

    def api_service
      @@api_service
    end

    def server_path(path = './docs')
      @server_path ||= path
    end

    def allow_headers=(headers)
      @@allow_headers = headers.map { |header| "--header #{header}" }.join(" ")
    end

    def allow_headers
      @@allow_headers
    end

    def default_format
      '*.apib'
    end

    def port
      @@port
    end

    def hostname
      @@hostname
    end

    def hostname=(host)
      @@hostname = host
    end

    def exclude_attributes
      @@exclude_attributes
    end
  end
end
