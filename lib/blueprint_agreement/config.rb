module BlueprintAgreement
  module Config
    extend self
    @@active_service = nil
    @@exclude_attributes = nil

    def configure; yield self end

    def port=(port)
      @port = port
    end

    def server_path=(server_path)
      @server_path = server_path
    end

    def exclude_attributes=(exclude_attributes)
      @@exclude_attributes = exclude_attributes
    end

    def active_service?
      !!@@active_service
    end

    def active_service=(active_service)
      @@active_service = active_service
    end

    def active_service
      @@active_service
    end

    def server_path(path = './docs')
      @server_path ||= path
    end

    def default_format
      '*.apib'
    end

    def port
      #default port so 8081
      @port || '8081'
    end

    def exclude_attributes
      @@exclude_attributes
    end
  end
end

