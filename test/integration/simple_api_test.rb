require 'test_helper'
require 'blueprint_agreement'

class RackTestSession
  def initialize
    @headers = { "Content-Type" => "application/json" }
  end
end

describe "Rack Test" do
  let(:body) { "\n{\n  'name': 'Hello World'\n}\n" }
  let(:last_request) { RailsMocks::Request.new(fullpath: endpoint) }
  let(:last_response) { RailsMocks::Response.new(body: body, request: last_request) }
  let(:rack_test_session) {  RackTestSession.new }

  before do
    module Rack; module Test; end; end
    BlueprintAgreement::Config.server_path('./test/fixtures')
  end

  describe 'when blueprint agreement was included but never used' do
    it 'returns a valid api request' do
      expect(true).must_equal(true)
    end
  end

  describe 'with valid request' do
    let(:endpoint){ '/message' }
    it 'returns a valid api request' do
      last_response.shall_agree_upon('hello_api.md')
    end
  end

  describe 'with invalid request' do
    let(:endpoint){ '/not_valid' }
    it 'returns a Not Found Route error' do
      expect { last_response.shall_agree_upon('hello_api.md') }.must_raise(BlueprintAgreement::EndpointNotFound)
    end
  end
end
