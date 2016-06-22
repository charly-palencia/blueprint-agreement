module Minitest
  module Assertions
    def assert_shall_agree_upon contract_name, response
      result    = BlueprintAgreement::Utils.response_parser(response.body)
      server    = BlueprintAgreement::Utils::Server.new

      begin
        server.start(contract_name)
        request = BlueprintAgreement::Utils::Request.from(self)
        requester = BlueprintAgreement::Utils::Requester.new(request, server)
        expected  = BlueprintAgreement::Utils.response_parser(requester.perform.body)
        assert_equal expected, result
      ensure
        server.stop
      end
    end
  end
end
