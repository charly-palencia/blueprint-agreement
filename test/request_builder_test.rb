require 'test_helper'
require './lib/blueprint_agreement/request_builder'

describe BlueprintAgreement::RequestBuilder do
  let(:described_class) { BlueprintAgreement::RequestBuilder }

  describe '.for' do
    let(:context) { mock() }
    let(:result) { described_class.for(context) }

    describe 'when rails is defined' do
      before do
        described_class.stubs(:rails?).returns(true)
        described_class.stubs(:rack_test?).returns(false)
      end

      it 'returns rails request instance' do
        expect(described_class.for(context)).must_be_kind_of(described_class::RailsRequest)
      end
    end

    describe 'when rack-test is defined' do
      before do
        described_class.stubs(:rails?).returns(false)
        described_class.stubs(:rack_test?).returns(true)
      end

      it 'returns a rack test request instance' do
        expect(described_class.for(context)).must_be_kind_of(described_class::RackTestRequest)
      end
    end
  end
end
