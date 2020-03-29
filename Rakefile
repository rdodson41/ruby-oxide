# frozen_string_literal: true

require('bundler/gem_tasks')
require('rspec/core/rake_task')

RSpec::Core::RakeTask.new(:spec)

require('rake/extensiontask')

task(build: :compile)

Rake::ExtensionTask.new('oxide/parser')
Rake::ExtensionTask.new('oxide/scanner')

task(default: %i[clobber compile spec])
