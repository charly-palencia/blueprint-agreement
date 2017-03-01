require 'test_helper'
require 'ostruct'
require 'blueprint_agreement'

describe BlueprintAgreement::Requester do
  let(:described_class) { BlueprintAgreement::Requester }

  it 'creates an instance with valid method' do
    methods = %w( GET POST PUT DELETE PATCH TRACE OPTIONS )

    methods.each do |method|
      request = OpenStruct.new(request_method: method, fullpath: '/path')
      expect(described_class.new(request)).must_be_kind_of(described_class)
    end
  end

  it 'raises an error with invalid method' do
    request = OpenStruct.new(request_method: 'INVALID', fullpath: '/path')
    expect {described_class.new(request)}.must_raise(BlueprintAgreement::HttpMethodNotFoundError)
  end
end
