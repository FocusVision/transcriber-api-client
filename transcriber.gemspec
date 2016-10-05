# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transcriber/version'

Gem::Specification.new do |spec|
  spec.name = 'transcriber'
  spec.version = Transcriber::VERSION
  spec.authors = ['Emanuele Tozzato']
  spec.email = ['etozzato@focusvision.com']

  spec.summary = %q{A GEM that interfaces with the transcription API}
  spec.description = %q{a gem that interfaces with the transcription API. This will be able to make requests and parse responses from the transcription API.}
  spec.homepage = 'http://focusvision.com'
  spec.license = 'MIT'


  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
end
