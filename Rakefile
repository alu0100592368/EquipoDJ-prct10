$:.unshift File.dirname(__FILE__) + 'lib'

require "bundler/gem_tasks"
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec


desc "Run lib/matrix.rb"
task :bin do
  sh "ruby lib/matrix.rb"
end


desc "Run tests with --format documentation"
task :spec do
  sh "rspec -I. spec/ordenacion_spec.rb --format documentation"
end
