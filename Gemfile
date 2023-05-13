# frozen_string_literal: true

source "https://rubygems.org"

gemspec

raw_rails_version = ENV.fetch("RAILS_VERSION", "6.1.0")
rails_version = "~> #{raw_rails_version}"

gem "activesupport", rails_version
gem "activemodel", rails_version
gem "activerecord", rails_version, group: :test


group :test do
  gem "faker"
end

group :development do
  gem "byebug"
  gem "rake"
  gem "rspec", "~> 3.0"
  gem "rake-compiler"
end

