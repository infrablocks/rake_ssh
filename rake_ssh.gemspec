# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_ssh/version'

Gem::Specification.new do |spec|
  spec.name = 'rake_ssh'
  spec.version = RakeSSH::VERSION
  spec.authors = ['InfraBlocks Maintainers']
  spec.email = ['maintainers@infrablocks.io']

  spec.summary = 'Rake tasks for managing SSH keys.'
  spec.description = 'Allows generation of SSH keys.'
  spec.homepage = "https://github.com/infrablocks/rake_ssh"
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(bin|lib|CODE_OF_CONDUCT\.md|confidante\.gemspec|Gemfile|LICENSE\.txt|Rakefile|README\.md)})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'rake_factory', '~> 0.23'
  spec.add_dependency 'sshkey', '~> 2.0'
  spec.add_dependency 'colored2', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rake_circle_ci', '~> 0.9'
  spec.add_development_dependency 'rake_github', '~> 0.5'
  spec.add_development_dependency 'rake_ssh', '~> 0.4'
  spec.add_development_dependency 'rake_gpg', '~> 0.12'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'gem-release', '~> 2.0'
  spec.add_development_dependency 'activesupport', '~> 5.2'
  spec.add_development_dependency 'memfs', '~> 1.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
