module BlueprintAgreement
  class HttpMethodNotFoundError < StandardError; end

  class EndpointNotFoundError < StandardError
    attr :request, :response

    def initialize(request)
      @request = request
      @response = request
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
