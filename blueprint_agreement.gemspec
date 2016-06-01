# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blueprint_agreement/version'

Gem::Specification.new do |spec|
  spec.name          = "blueprint_agreement".freeze
  spec.version       = BlueprintAgreement::VERSION
  spec.authors       = ["Charly Palencia"]
  spec.email         = ["charly.palencia@koombea.com"]
  spec.summary       = %q{A Minitest API Documentation Matcher , based on ApiBluePrint schema.}
  spec.description   = %q{A Minitest API Documentation Matcher , based on ApiBluePrint schema.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'byebug'

  spec.add_runtime_dependency("minitest", ["~> 5.8"])
  spec.add_runtime_dependency("railties", ["~> 5.0.0.beta3"])
end
