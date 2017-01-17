module Minitest
  module Assertions
    def assert_shall_agree_upon contract_name, response
      result = response.body
      api_service = BlueprintAgreement::Config.api_service.new
      server = BlueprintAgreement::Server.new(config: BlueprintAgreement::Config, api_service: api_service)

      begin
        server.start(contract_name)
        request = BlueprintAgreement::RequestBuilder.for(self)
        requester = BlueprintAgreement::Utils::Requester.new(request, server)
        expected = requester.perform.body.to_s

        unless BlueprintAgreement::Config.exclude_attributes.nil?
          filters = BlueprintAgreement::Config.exclude_attributes
          result = BlueprintAgreement::ExcludeFilter.deep_exclude(
            BlueprintAgreement::Utils.to_json(result),
            filters)
          expected = BlueprintAgreement::ExcludeFilter.deep_exclude(
            BlueprintAgreement::Utils.to_json(expected),
            filters)
        end

        result = BlueprintAgreement::Utils.response_parser(result)
        expected = BlueprintAgreement::Utils.response_parser(expected)

        assert_equal expected, result
      end
    end
  end
end
