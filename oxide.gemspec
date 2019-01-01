lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require('oxide/version')

Gem::Specification.new do |spec|
  spec.name          = 'oxide'
  spec.version       = Oxide::VERSION
  spec.authors       = ['Richard E. Dodson']
  spec.email         = ['richard.elias.dodson@gmail.com']

  spec.summary       = 'An implementation of the Oxide Programming Language ' \
    'which is written in Ruby.'
  spec.homepage      = 'https://github.com/rdodson41/ruby-oxide'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files         =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
      end
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('bundler', '~> 1.17')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('pry-byebug')
  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('rubocop-rspec')
  spec.add_development_dependency('simplecov')

  spec.required_ruby_version = '>= 2.2.0'
end
