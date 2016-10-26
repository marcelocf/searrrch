# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'search_operators'

Gem::Specification.new do |spec|
  spec.name          = "search_operators"
  spec.version       = SearchOperators::VERSION
  spec.authors       = ["Marcelo Coraça de Freitas"]
  spec.email         = ["marcelo.freitas@finc.com"]
  spec.summary       = %q{Really simple library to parse and handle gmail like parameters - called here 'operators'}
  spec.homepage      = %q{http://github.com/bruce/keyword_search}
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.rdoc_options  = ["--charset=UTF-8"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "guard-rspec"
end
