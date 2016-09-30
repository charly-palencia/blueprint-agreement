ROOT_PATH = File.dirname(__FILE__)
Dir[ File.join(ROOT_PATH, "tasks/**/*.rake")].sort.each { |ext| load ext }
require "bundler/gem_tasks"

task default: [:test]
