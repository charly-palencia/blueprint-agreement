module Minitest
  module Assertions
    def assert_shall_agree_upon(contract_name, test_response)
      BlueprintAgreement.service.start(contract_name)
      request = BlueprintAgreement::RequestBuilder.for(self)
      requester = BlueprintAgreement::Requester.new(request)
      contract_response = requester.perform
      contract_response_body = contract_response.body.to_s
      test_response_body = test_response.body

      unless BlueprintAgreement.configuration.exclude_attributes.nil?
        filters = BlueprintAgreement.configuration.exclude_attributes
        contract_response_body = BlueprintAgreement::ExcludeFilter.deep_exclude(
          BlueprintAgreement::ResponseParser.to_json(contract_response_body),
          filters
        )
        test_response_body = BlueprintAgreement::ExcludeFilter.deep_exclude(
          BlueprintAgreement::ResponseParser.to_json(test_response_body),
          filters
        )
      end
      contract_response_body = BlueprintAgreement::ResponseParser.prettify_json(contract_response_body)
      test_response_body = BlueprintAgreement::ResponseParser.prettify_json(test_response_body)

      assert_equal test_response_body, contract_response_body
    end
  end
end
