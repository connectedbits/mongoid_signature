require "rubygems"
require "rake"
require "rake/rdoctask"
require "rspec"
require "rspec/core/rake_task"
require 'rake/gempackagetask'

gemspec = eval(File.read('mongoid_signature.gemspec'))
Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

desc "build the gem and release it to rubygems.org"
task :release => :gem do
  sh "gem push pkg/mongoid_signature-#{gemspec.version}.gem"
end

desc 'Generate documentation for the mongoid_signature plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MongoidSignature'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rspec::Core::RakeTask.new('spec:unit') do |spec|
  spec.pattern = "spec/unit/**/*_spec.rb"
end

task :spec => ['spec:unit']

task :default => :spec