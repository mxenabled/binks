# frozen_string_literal: true

lib = ::File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "binks/version"

::Gem::Specification.new do |spec|
  spec.name        = "binks"
  spec.version     = ::Binks::VERSION
  spec.authors     = ["MX Engineering"]
  spec.email       = ["dev@mx.com"]

  spec.summary     = "GitLab JAR release management"
  spec.description = ""
  spec.homepage    = "https://gitlab.mx.com/mx/binks"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://gems.internal.mx"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|go)/})
  end
  spec.bindir        = "exe"
  spec.executables   = ["binks"]
  spec.require_paths = ["lib"]

  # spec.add_dependency "nokogiri", ">= 1.10.4"
  spec.add_dependency "thor",     ">= 0.20.3"

  spec.add_development_dependency "bundler", ">= 1.16.0"
  spec.add_development_dependency "mad_rubocop"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
end
