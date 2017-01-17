module BlueprintAgreement
  class Server
    attr_reader :host

    def initialize(config:, api_service:)
      @config = config
      @api_service = api_service
      @host = @api_service.host
    end

    def start(path = @config.default_format)
      @api_service.install unless @api_service.installed?

      if @api_service.running?
        @api_service.restart(path) if @api_service.path != path
      else
        @api_service.start(path)
      end
    end

    def stop
      @api_service.stop
    end
  end
end
