# coding: utf-8
Gem::Specification.new do |s|
  s.name = "rspec-skull-and-crossbones"
  s.platform = Gem::Platform::RUBY
  s.version = "0.1"
  s.date = "2015-02-16"
  s.summary = "SKULL_AND_CROSSBONES RSpec formatter"
  s.description = "Prints '☠' (unicode SKULL_AND_CROSSBONES) for failing specs."
  s.authors = ["Martin Frost"]
  s.email = "frost@ceri.se"
  s.homepage = "http://martinfrost.name"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rspec", "~> 3.2"
end
