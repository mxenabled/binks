# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "fileutils"

::RSpec::Core::RakeTask.new(:spec)
::RuboCop::RakeTask.new(:rubocop)

desc "Run RuboCop and RSpec"
task :default => %i(rubocop spec)
