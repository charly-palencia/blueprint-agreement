require 'test_helper'
require './lib/blueprint_agreement/server'

describe BlueprintAgreement::Server do
  let(:config) { mock() }
  let(:api_service) { ApiService.new(config) }
  let(:described_class) { BlueprintAgreement::Server }
  let(:instance) { described_class.new(api_service: api_service, config: config) }

  describe '#start' do
    let(:config) { mock(default_format: '*.apib') }

    describe 'when api service is not installed' do
      before do
        api_service.stubs(:installed?).returns(false).once
        api_service.stubs(:install).returns(true).once
        api_service.stubs(:start).returns(true).once
      end

      it 'should install api service' do
        expect(instance.start).must_equal true
      end
    end

    describe 'when api service is already installed' do
      before do
        api_service.stubs(:installed?).returns(true).once
        api_service.stubs(:install).never
        api_service.stubs(:start).returns(true).once
      end

      it 'should start api service without install service' do
        expect(instance.start).must_equal true
      end
    end
  end

  describe '#stop' do
    before do
      api_service.stubs(:stop).returns(true).once
    end

    it 'should the api service' do
      expect(instance.stop).must_equal true
    end
  end
end
