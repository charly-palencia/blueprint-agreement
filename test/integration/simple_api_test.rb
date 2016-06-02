require 'test_helper'
require 'blueprint_agreement'

describe "SimpleApi" do
  let(:body) { "\n{\n  'name': 'Hello World'\n}\n" }
  let(:request) { RailsMocks::Request.new(fullpath: endpoint) }
  let(:response) { RailsMocks::Response.new(body: body, request: request) }

  before do
    BlueprintAgreement::Config.server_path('./test/fixtures')
  end

  describe 'with valid request' do
    let(:endpoint){ '/message' }
    it 'returns a valid api request' do
      response.shall_agree_upon('hello_api.md')
    end
  end

  describe 'with invalid request' do
    let(:endpoint){ '/not_valid' }
    it 'returns a Not Found Route error' do
      expect { response.shall_agree_upon('hello_api.md') }.must_raise(BlueprintAgreement::EndpointNotFound)
    end
  end
end
