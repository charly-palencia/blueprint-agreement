require 'test_helper'
require 'ostruct'
require 'blueprint_agreement/errors'
require 'blueprint_agreement/utils/requester'

describe BlueprintAgreement::Utils::Requester do
  let(:described_class) { BlueprintAgreement::Utils::Requester }

  it 'creates an instance with valid method' do
    methods = %w( GET POST PUT DELETE PATCH TRACE OPTIONS )

    methods.each do |method|
      request = OpenStruct.new(request_method: method)
      server= OpenStruct.new
      expect(described_class.new(request, server)).must_be_kind_of(described_class)
    end
  end

  it 'raises an error with invalid method' do
    request = OpenStruct.new(request_method: 'INVALID')
    server= OpenStruct.new
    expect {described_class.new(request, server)}.must_raise(BlueprintAgreement::MethodNotFound)
  end
end
