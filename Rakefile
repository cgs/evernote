require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "evernote"
    gem.summary = %Q{High level wrapper for the Evernote API}
    gem.email = "chris.sepic@gmail.com"
    gem.homepage = "http://github.com/cgs/evernote"
    gem.authors = ["Chris Sepic"]
    gem.files.include %w{vendor/**/* spec/evernote/auth.yaml}
    gem.add_dependency("thrift_client")
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "yard"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = %w{ --colour }
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = %w{ --colour }
  spec.rcov_opts = %w{ --exclude gems\/,spec\/ -t}
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
