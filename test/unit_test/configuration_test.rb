require "test_helper"
require "./lib/blueprint_agreement/configuration"

describe BlueprintAgreement::Configuration do
  let(:subject) { BlueprintAgreement::Configuration.new }

  describe 'allow headers' do
    it 'allows setting the allowed headers' do
      subject.allow_headers = ['Authorization', 'Cookie']
      subject.allow_headers.must_equal('--header Authorization --header Cookie')
      subject.allow_headers = []
    end
  end

  describe 'port' do
    after do
      subject.port = '8082'
    end

    it 'defaults to 8082' do
      subject.port.must_equal('8082')
    end

    it 'sets the port' do
      subject.port = '8080'
      subject.port.must_equal('8080')
      subject.port = '8082'
    end
  end

  describe 'hostname' do
    after do
      subject.hostname = 'http://localhost'
    end

    it 'sets the hostname' do
      subject.hostname = 'http://host.test'
      subject.hostname.must_equal('http://host.test')
    end
  end
end
