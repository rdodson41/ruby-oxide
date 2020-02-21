require_relative('lib/oxide/version')

Gem::Specification.new do |spec|
  spec.name          = 'oxide'
  spec.version       = Oxide::VERSION
  spec.authors       = ['Richard E. Dodson']
  spec.email         = ['richard.elias.dodson@icloud.com']

  spec.summary       = 'An implementation of the Oxide Programming Language ' \
                       'that is written in Ruby.'
  spec.homepage      = 'https://github.com/rdodson41/ruby-oxide'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rdodson41/ruby-oxide'
  spec.metadata['changelog_uri'] = 'https://github.com/rdodson41/ruby-oxide/issues'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = []
end
