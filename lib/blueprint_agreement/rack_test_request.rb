module BlueprintAgreement
  class RackTestRequest
    def initialize(context)
      @context = context
      @request = context.last_request
    end

    def body
      @body ||= @request.body.read
    end

    def content_type
      @request.content_type
    end

    def request_method
      @request.request_method
    end

    def fullpath
      @request.fullpath
    end

    def headers
      @context.rack_test_session.instance_variable_get(:@headers)
    end
  end
end
