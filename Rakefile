require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"
require_relative "ext/ostn02c"

CLEAN.include OSTN02C.object_path

Rake::ExtensionTask.new "national_grid" do |ext|
  ext.lib_dir = "lib/national_grid"
end

Rake::TestTask.new "test" => "compile" do |test|
  test.pattern = "test/**/*_test.rb"
end

task "default" => "test"
