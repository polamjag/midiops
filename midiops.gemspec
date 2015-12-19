# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'midiops/version'

Gem::Specification.new do |spec|
  spec.name          = "midiops"
  spec.version       = MIDIOps::VERSION
  spec.authors       = ["polamjag"]
  spec.email         = ["s@polamjag.info"]

  spec.summary       = %q{A MIDI Operator.}
  spec.description   = "MIDIOps is to automate some works with MIDI events"
  spec.homepage      = "https://github.com/polamjag/midiops"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "unimidi"
  spec.add_dependency "eventmachine"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
