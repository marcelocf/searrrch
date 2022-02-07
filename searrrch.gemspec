# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'searrrch/version'

Gem::Specification.new do |spec|
  spec.name          = "searrrch"
  spec.version       = Searrrch::VERSION
  spec.authors       = ["Marcelo Coraça de Freitas"]
  spec.email         = ["marcelo.freitas@finc.com"]
  spec.summary       = %q{Really simple library to parse and handle gmail like parameters - called here 'operators'}
  spec.homepage      = %q{https://github.com/marcelocf/searrrch}
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.rdoc_options  = ["--charset=UTF-8"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "coveralls"
end
