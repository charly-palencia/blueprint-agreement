gem "minitest"
require "minitest"
require "minitest"
require "minitest/spec"
require "minitest/mock"
require "blueprint_agreement/version"
require 'blueprint_agreement/config'
require 'blueprint_agreement/utils/request_logger'
require 'blueprint_agreement/utils/server'
require 'blueprint_agreement/utils/requester'
require 'blueprint_agreement/utils/response_parser'
require 'blueprint_agreement/minitest/assertions'
require 'blueprint_agreement/minitest/expectations'

module BlueprintAgreement
  Config.configure do |config|
    config.port = '8082'
  end
end
