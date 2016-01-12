require "bundler"
Bundler::GemHelper.install_tasks
require "rspec/core/rake_task"
require_relative "lib/slow_skull_formatter"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = "--format SlowSkullFormatter --color"
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
