# frozen_string_literal: true

require_relative "lib/fritanga/version"

Gem::Specification.new do |spec|
  spec.name = "fritanga"
  spec.version = RustReverse::VERSION
  spec.authors = ["Ian Ker-Seymer"]
  spec.email = ["ian.kerseymer@shopify.com"]

  spec.summary = "Fast reverse in Rust"
  spec.description = "A test gem"
  spec.homepage = "https://github.com/oxidize-rb/rb-sys"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.3.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*.rb", "ext/**/*.{rs,toml,lock,rb}"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/fritanga/extconf.rb"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rb_sys"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
