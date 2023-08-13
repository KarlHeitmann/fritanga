# frozen_string_literal: true

require "rake/testtask"
require "rake/extensiontask"

SOURCE_PATTERN = "*.{rs,toml,lock,rb}"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

Rake::ExtensionTask.new("fritanga") do |ext|
  ext.lib_dir = "lib/fritanga"
  ext.source_pattern = SOURCE_PATTERN
  ext.cross_compile = true
  ext.cross_platform = %w[x86-mingw32 x64-mingw-ucrt x64-mingw32 x86-linux x86_64-linux x86_64-darwin arm64-darwin aarch64-linux]
  ext.config_script = ENV["ALTERNATE_CONFIG_SCRIPT"] || "extconf.rb"
end

task :build do
  require "bundler"

  spec = Bundler.load_gemspec("fritanga.gemspec")

  FileUtils.rm_rf("pkg/fritanga")

  spec.files.each do |file|
    FileUtils.mkdir_p("pkg/fritanga/#{File.dirname(file)}")
    FileUtils.cp(file, "pkg/fritanga/#{file}")
  end

  FileUtils.cp("fritanga.gemspec", "pkg/fritanga")

  full_path = File.expand_path("./../../../crates/rb-sys", __FILE__)
  cargo_toml_path = "pkg/fritanga/ext/fritanga/Cargo.toml"
  new_contents = File.read(cargo_toml_path).gsub("./../../../../crates/rb-sys", full_path)
  FileUtils.rm(cargo_toml_path)
  File.write(cargo_toml_path, new_contents)

  Dir.chdir("pkg/fritanga") do
    sh "gem build fritanga.gemspec --output=../fritanga.gem"
  end
end

task default: %i[compile test]
