require 'json'

module BlueprintAgreement
  module Utils
    def self.response_parser(response)
      JSON.pretty_generate(JSON.parse(response || ""))
    rescue JSON::ParserError
      return response.to_s.lstrip
    end
  end
end
