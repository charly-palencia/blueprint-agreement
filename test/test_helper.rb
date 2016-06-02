require 'bundler/setup'
Bundler.setup
require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/mini_test'

ROOT_PATH = File.dirname(__FILE__)
Dir[File.join(ROOT_PATH, "support/**/*.rb")].each { |f| require f }
