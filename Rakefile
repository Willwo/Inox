require 'spec/rake/spectask'

task :default => ["spec/core"]


task :spec => ["spec/core"]

Spec::Rake::SpecTask.new('spec/core') do |t|
  t.spec_files = FileList['spec/core/*_spec.rb']
  t.rcov = true
end