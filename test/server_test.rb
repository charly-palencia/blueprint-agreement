require 'test_helper'
require './lib/blueprint_agreement/server'

describe BlueprintAgreement::Server do
  let(:api_service) { TestApiService.new(config) }
  let(:described_class) { BlueprintAgreement::Server }
  let(:instance) { described_class.new(config: config, api_service: api_service) }
  let(:config) { mock() }

  describe '#start' do
    let(:config) { mock(default_format: '*.apib') }

    describe 'when api service is not installed' do
      let(:api_service){ nil }
      before do
        config.unstub(:ap_service)
        config.stubs(:api_service).returns(api_service).once
        api_service.stubs(:installed?).returns(false).once
        api_service.stubs(:install).returns(true).once
        api_service.stubs(:start).returns(true).once
      end

      it 'should install api service' do
        expect(instance.start).must_equal true
      end
    end

    describe 'when api service is already installed' do
      let(:config) { mock(default_format: '*.apib') }

      before do
        api_service.stubs(:installed?).returns(true).once
        api_service.stubs(:install).never
      end

      describe 'and an active service exists' do
        it 'does not stop the service when it is the same path' do
          config.unstub(:api_service)
          config.stubs(:api_service).returns(api_service).twice
          api_service.stubs(:stop).returns(true).never
          api_service.stubs(:start).returns(true).never
          instance.start
        end

        it 'restarts the service' do
          config.unstub(:default_format)
          config.unstub(:api_service)
          config.stubs(:api_service).returns(api_service).twice
          config.stubs(:default_format).never
          api_service.stubs(:stop).returns(true).once
          api_service.stubs(:start).returns(true).once
          instance.start('differnt.apib')
        end
      end

      describe 'without any active service' do
        it 'stops the service and start again with a new api_service' do
          config.stubs(:api_service).returns(nil)
          api_service.stubs(:start).returns(true).once
          instance.start
        end
      end

    end
  end

  describe '#stop' do
    before do
      api_service.stubs(:stop).returns(true).once
      config.stubs(:api_service)
    end

    it 'should the api service' do
      expect(instance.stop).must_equal true
    end
  end
end
