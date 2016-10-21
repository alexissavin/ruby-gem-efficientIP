# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "SOLIDserver"
  spec.version       = "6.0.0"
  spec.date          = "2016-09-09"
  spec.authors       = ["Alexis Savin"]
  spec.email         = ["alexis.savin@gmail.com"]
  spec.description   = %q{A Ruby Object wrapper of SOLIDserver's REST API}
  spec.summary       = %q{This gem provide a Ruby object interface to EfficientIP's SOLIDserver REST API}
  spec.homepage      = "https://github.com/alexissavin/ruby-gem-efficientIP"
  spec.license       = "BSD 2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.0'
  spec.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'
end
