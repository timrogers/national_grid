require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"
require_relative "ext/ostn02c"

CLEAN.include OSTN02C.object_path

file OSTN02C.library => OSTN02C.sources do
  OSTN02C.make or fail "Building libostn02 failed"
end

Rake::ExtensionTask.new "national_grid" do |ext|
  ext.lib_dir = "lib/national_grid"
end

Rake::Task["compile"].prerequisites.unshift FileList[OSTN02C.library]

Rake::TestTask.new "test" => "compile" do |test|
  test.pattern = "test/**/*_test.rb"
end

task "default" => "test"
