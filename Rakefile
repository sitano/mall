require "bundler/gem_tasks"
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("mall") do |ext|
  # ext.lib_dir = "lib/mall"
end

task :default => [:clobber, :compile, :spec]
