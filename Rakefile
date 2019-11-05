# frozen_string_literal: true

require('bundler/gem_tasks')
require('rake/extensiontask')
require('rspec/core/rake_task')

Rake::ExtensionTask.new('parser') do |ext|
  ext.lib_dir = 'lib/oxide'
end

Rake::ExtensionTask.new('scanner') do |ext|
  ext.lib_dir = 'lib/oxide'
end

RSpec::Core::RakeTask.new(:spec)

task(default: %i[compile spec])
