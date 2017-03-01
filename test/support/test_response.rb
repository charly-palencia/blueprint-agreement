class TestResponse
  attr_reader :body, :request

  def initialize(body:, request:)
    @body = body
    @request = request
  end
end
