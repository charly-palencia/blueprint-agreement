require "minitest"
require "minitest/spec"
require "minitest/mock"
require "blueprint_agreement/version"
require 'blueprint_agreement/config'
require 'blueprint_agreement/errors'
require 'blueprint_agreement/api_services/drakov_service'
require "blueprint_agreement/server"
require 'blueprint_agreement/request_builder'
require 'blueprint_agreement/utils/request_logger'
require 'blueprint_agreement/utils/requester'
require 'blueprint_agreement/utils/response_parser'
require 'blueprint_agreement/utils/exclude_filter'
require 'blueprint_agreement/minitest/assertions'
require 'blueprint_agreement/minitest/expectations'

# ========================== BluePrintAgreement ==================================
# +-----------+         +-------------------+              +-----------------+
# | Minitest  |         | BlueprintAgreement|              |Node Environment |
# +----+------+         +---------+---------+              +-----------------+
#      |                          |                                |
#      |    shall_agree_with      |                                |
#      +------------------------> |    /documentation_endpoint     |
#      |                          +------------------------------> |
#      |                          |                                |
#      |                          |                                |
#      |                          |                                |
#      |                          |          <response>            |
#      |                          | <----------------------------+ |
#      |                          |                                |
#      |       assert_equal       |                                |
#      | <------------------------+                                |
#      |                          |                                |
#      |                          |                                |
#      |                          |                                |
#      |                          |                                |
#      |                          |                                |
#      |                          |                                |
#    +-+-+                     +--+--+                           +-+-+
#
module BlueprintAgreement
end

Minitest.after_run do
  if BlueprintAgreement::Config.active_service?
    Process.kill 'TERM', BlueprintAgreement::Config.active_service[:pid]
  end
end
