module BlueprintAgreement
  class EndpointNotFound < StandardError;
    attr :request, :response

    def initialize(request)
      @request = request
      @response = request.response
    end

    def message
      %{
          Response:
          uri: #{response.uri}
          code: #{response.code}
          body: #{response.msg}
          }
    end
  end
end
