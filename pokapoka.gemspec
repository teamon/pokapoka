# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pokapoka/version'

Gem::Specification.new do |gem|
  gem.name          = "pokapoka"
  gem.version       = Pokapoka::VERSION
  gem.authors       = ["Tymon Tobolski"]
  gem.email         = ["i@teamon.eu"]
  gem.description   = %q{Show .md files}
  gem.summary       = %q{Show .md files}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rack"
  gem.add_dependency "github-markdown"
end
