$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
Bundler.setup
require "minitest"
require 'minitest/autorun'
require 'minitest/unit'
require "minitest/spec"
require "minitest/mock"
require 'mocha/mini_test'

ROOT_PATH = File.dirname(__FILE__)
Dir[File.join(ROOT_PATH, "support/**/*.rb")].each { |f| require f }

class ApiService

  def initialize(config)
    @config = config
  end

  def start; end
  def installed?; end
  def install; end
  def stop; end
  def options; end
end
