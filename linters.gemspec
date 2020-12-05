lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linters/version'

Gem::Specification.new do |spec|
  spec.name          = 'linters'
  spec.version       = Linters::VERSION
  spec.authors       = ['skrinits']
  spec.email         = ['110100reg@gmail.com']

  spec.summary       = "Tool checks ruby applications using different code's analyzers."
  spec.description   = 'Check of ruby applications using rubocop, reek, brakeman, fasterer, bundle_audit and the other custom linters'
  spec.homepage      = 'https://github.com/skrinits/linters'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rake'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'bundler-audit', '~> 0.6'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'fasterer', '~> 0.5'
  spec.add_development_dependency 'reek', '~> 5.4'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.71'
end
