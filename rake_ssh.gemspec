# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_ssh/version'

files = %w[
  bin
  lib
  CODE_OF_CONDUCT.md
  rake_ssh.gemspec
  Gemfile
  LICENSE.txt
  Rakefile
  README.md
]

Gem::Specification.new do |spec|
  spec.name = 'rake_ssh'
  spec.version = RakeSSH::VERSION
  spec.authors = ['InfraBlocks Maintainers']
  spec.email = ['maintainers@infrablocks.io']

  spec.summary = 'Rake tasks for managing SSH keys.'
  spec.description = 'Allows generation of SSH keys.'
  spec.homepage = 'https://github.com/infrablocks/rake_ssh'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(/^(#{files.map { |g| Regexp.escape(g) }.join('|')})/)
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1'

  spec.add_dependency 'colored2', '~> 3.1'
  spec.add_dependency 'rake_factory', '~> 0.33'
  spec.add_dependency 'sshkey', '~> 2.0'

  spec.metadata['rubygems_mfa_required'] = 'false'
end
