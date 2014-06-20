# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "retrier"
  gem.version       = "1.0.0"
  gem.authors       = ["Boris Filipov"]
  gem.email         = ["bfilipov+rubygems@gmail.com"]
  gem.description   = %q{ Retries a code block the given number of times }
  gem.homepage      = "https://github.com/borfd/retrier"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
end
