module Minitest
  module Assertions
    def assert_shall_agree_upon(contract_name, response)
      BlueprintAgreement.service.start(contract_name)
      request = BlueprintAgreement::RequestBuilder.for(self)
      requester = BlueprintAgreement::Requester.new(request)
      requester.perform

      # OK
      api_service = BlueprintAgreement::DrakovService.new(BlueprintAgreement.configuration)
      server      = BlueprintAgreement::Server.new(
        api_service: api_service,
        config: BlueprintAgreement.configuration
      )

      # begin
      #   server.start(contract_name)
      #   request = BlueprintAgreement::RequestBuilder.for(self)
      #   requester = BlueprintAgreement::Utils::Requester.new(request, server)
      #   expected  = requester.perform.body.to_s

      #   unless BlueprintAgreement.configuration.exclude_attributes.nil?
      #     filters = BlueprintAgreement.configuration.exclude_attributes
      #     result = BlueprintAgreement::ExcludeFilter.deep_exclude(
      #       BlueprintAgreement::Utils.to_json(result),
      #       filters)
      #     expected = BlueprintAgreement::ExcludeFilter.deep_exclude(
      #       BlueprintAgreement::Utils.to_json(expected),
      #       filters)
      #   end

      #   result = BlueprintAgreement::Utils.response_parser(response.body)
      #   expected = BlueprintAgreement::Utils.response_parser(expected)

      #   assert_equal expected, result
      # end
    end
  end
end
