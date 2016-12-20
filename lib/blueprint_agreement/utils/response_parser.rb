require 'json'

module BlueprintAgreement
  module Utils
    extend self

    def to_json(content)
      return content if content.nil?

      JSON.parse(content, symbolize_names: true)
    rescue JSON::ParserError
      return content.to_s.lstrip
    end

    def response_parser(response)
      return content if response.nil?

      response = JSON.parse(response) if response.is_a? String
      JSON.pretty_generate(response)
    rescue JSON::ParserError
      return response.to_s.lstrip
    end
  end
end
