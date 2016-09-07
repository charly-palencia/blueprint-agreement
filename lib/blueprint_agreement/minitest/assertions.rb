module Minitest
  module Assertions
    def assert_shall_agree_upon contract_name, response
      result    = BlueprintAgreement::Utils.response_parser(response.body)
      api_service =  BlueprintAgreement::DrakovService.new
      server    = BlueprintAgreement::Server.new(
        api_service: api_service,
        config: BlueprintAgreement::Config
      )

      begin
        server.start(contract_name)
        request = BlueprintAgreement::RequestBuilder.for(self)
        requester = BlueprintAgreement::Utils::Requester.new(request, server)
        expected  = BlueprintAgreement::Utils.response_parser(requester.perform.body)
        assert_equal expected, result
      end
    end
  end
end
