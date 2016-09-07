module BlueprintAgreement
  class Server

    def initialize(api_service:, config:)
      @api_service = api_service
      @config = config
    end

    def start(path=@config.default_format)
      @api_service.install unless @api_service.installed?

      if @config.active_service
        restart(path) if @config.active_service[:path] != path
      else
        @api_service.start(path)
      end
    end

    def restart(path)
      stop && @api_service.start(path)
    end

    def stop
      @api_service.stop
    end

    def host
      @api_service.host
    end
  end
end
