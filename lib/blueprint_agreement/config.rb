module BlueprintAgreement
  module Config
    extend self

    def configure; yield self end

    def port=(port)
      @port = port
    end

    def port
      #default port so 8081
      @port || '8081'
    end
  end
end

