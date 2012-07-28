# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shellfish/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Yuya Takeyama"]
  gem.email         = ["sign.of.the.wolf.pentagram@gmail.com"]
  gem.description   = %q{Solve problems, learn shell commands}
  gem.summary       = %q{Solve problems, learn shell commands}
  gem.homepage      = "https://github.com/yuya-takeyama/shellfish"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shellfish"
  gem.require_paths = ["lib"]
  gem.version       = Shellfish::VERSION
end