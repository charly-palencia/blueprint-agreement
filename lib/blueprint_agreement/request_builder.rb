module BlueprintAgreement
  class RequestBuilder
    def self.for(context)
      request_class = case
              when rails?
                RailsRequest
              when rack_test?
                RackTestRequest
              end

      request_class.new(context)
    end

    def self.rails?
      !!defined?(Rails)
    end

    def self.rack_test?
      !!defined?(Rack::Test)
    end
  end
end
