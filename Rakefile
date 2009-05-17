#--
# Copyright © 2009 William Wolf
# Find documentation at <http://www.ironicwolf.com>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#  
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#  
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require 'rubygems'
require 'rake/clean'

###############################################################################
# MANAGE GEM
###############################################################################
require 'rake/gempackagetask'

#
# Clean GEM
#
CLEAN.include("pkg")


#
# BUILD GEM
#
spec = Gem::Specification.new do |s|
    s.name       = "inox"
    s.version    = "0.0.1"
    s.author     = "William Wolf"
    s.email      = "william at ironicwolf dot com"
    s.homepage   = "http://www.ironicwolf.com"
    s.platform   = Gem::Platform::RUBY
    s.summary    = "Instant nitro open X"
    s.files      = FileList['lib/**/*.rb'].exclude("coverage", "pkg", "spec", "Rakefile").to_a
    s.require_path      = ['lib']
#    s.autorequire       = "inox"
#    s.test_file         = "test/runtest.rb"
    s.has_rdoc          = true
    s.extra_rdoc_files  = ['README']
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end


desc 'Install the gem file' 
task 'gem/install' => [:clean, :gem] do
  `gem install pkg/inox-0.0.1.gem`
end


desc 'Unnstall the gem file' 
task 'gem/uninstall' do
  res = `gem list -d inox`
  `gem uninstall inox` if res.empty?
end

###############################################################################
# MANAGE TEST e.g Rspec
###############################################################################
require 'spec/rake/spectask'


#
# CLEAN
#
CLEAN.include 'coverage'


#
# BUILD
#
Spec::Rake::SpecTask.new('tests') do |t|
  t.spec_files = FileList['spec/core/*_spec.rb']
  t.rcov = true
end


###############################################################################
# MANAGE Examples
###############################################################################

desc 'Returns a list of examples that can be run' 
task :examples do
  puts 'hello'
end

task 'examples/hello' => :gem do

  require 'examples/helloworld/helloworld.rb'
end

# task :default => :helloworld

# task :default => ["spec/core"]
# 
# 
# #task :spec => ["spec/core"]
# 

# 
# 
