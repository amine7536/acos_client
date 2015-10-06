# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acos_client/version'

Gem::Specification.new do |spec|
  spec.name = 'acos_client'
  spec.version = AcosClient::VERSION
  spec.authors = ['Amine Benseddik']
  spec.email = ['amine.benseddik@gmail.com']

  spec.summary = %q{A10network AxAPI client}
  spec.description = %q{Port Python A10network AxAPI client to Ruby}
  spec.homepage = 'https://github.com/amine7536/acos_client'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Only with ruby 2.0.x
  spec.required_ruby_version = '~> 2.0'
  
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 0.9.6'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'addressable'
  spec.add_development_dependency 'activesupport'
end
