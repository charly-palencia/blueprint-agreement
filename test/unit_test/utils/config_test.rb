require "test_helper"

describe BlueprintAgreement::Config do
  let(:subject) { BlueprintAgreement::Config }

  describe 'allow headers' do
    it 'allows setting the allowed headers' do
      subject.allow_headers = ['Authorization', 'Cookie']
      subject.allow_headers.must_equal('--header Authorization --header Cookie')
      subject.allow_headers = []
    end
  end

  describe 'port' do
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
    it 'sets the hostname' do
      subject.hostname = 'http://host.test'
      subject.hostname.must_equal('http://host.test')
      subject.hostname = 'http://localhost'
    end
  end
end
