# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gdoc/version'

Gem::Specification.new do |spec|
  spec.name          = "gdoc"
  spec.version       = Gdoc::VERSION
  spec.authors       = ["mjason"]
  spec.email         = ["tywf91@gmail.com"]
  spec.summary       = %q{一个文档dsl}
  spec.description   = %q{简单的方式生成好看的md文档}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
