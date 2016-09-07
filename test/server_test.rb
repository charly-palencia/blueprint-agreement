require 'test_helper'
require './lib/blueprint_agreement/server'

describe BlueprintAgreement::Server do
  let(:api_service) { ApiService.new(config) }
  let(:described_class) { BlueprintAgreement::Server }
  let(:instance) { described_class.new(api_service: api_service, config: config) }
  let(:config) { mock() }

  describe '#start' do
    let(:active_service) { { path: '*.apib' } }
    let(:config) { mock(default_format: '*.apib') }

    describe 'when api service is not installed' do
      let(:active_service){ nil }
      before do
        config.unstub(:active_service)
        config.stubs(:active_service).returns(active_service).once
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
          config.unstub(:active_service)
          config.stubs(:active_service).returns(active_service).twice
          api_service.stubs(:stop).returns(true).never
          api_service.stubs(:start).returns(true).never
          instance.start
        end

        it 'restarts the service' do
          config.unstub(:default_format)
          config.unstub(:active_service)
          config.stubs(:active_service).returns(active_service).twice
          config.stubs(:default_format).never
          api_service.stubs(:stop).returns(true).once
          api_service.stubs(:start).returns(true).once
          instance.start('differnt.apib')
        end
      end

      describe 'without any active service' do
        it 'stops the service and start again with a new active_service' do
          config.stubs(:active_service).returns(nil)
          api_service.stubs(:start).returns(true).once
          instance.start
        end
      end

    end
  end

  describe '#stop' do
    before do
      api_service.stubs(:stop).returns(true).once
      config.stubs(:active_service)
    end

    it 'should the api service' do
      expect(instance.stop).must_equal true
    end
  end
end
