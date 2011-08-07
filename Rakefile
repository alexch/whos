require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rspec/core/rake_task'

task :default => [:spec]
task :test => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
  ENV['ENV'] = "test"
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = ['-rubygems'] if defined? Gem
end

$spec =
  begin
    require 'rubygems/specification'    
    data = File.read('whos.gemspec')
    spec = nil
    Thread.new { spec = eval("$SAFE = 2\n#{data}") }.join
    spec
  end

def package(ext='')
  "pkg/#{$spec.name}-#{$spec.version}" + ext
end

desc 'Build packages'
task :package => %w[.gem .tar.gz].map { |e| package(e) }

desc 'Build and install as local gem'
task :install => package('.gem') do
  sh "gem install #{package('.gem')}"
end

directory 'pkg/'
CLOBBER.include('pkg')

file package('.gem') => %W[pkg/ #{$spec.name}.gemspec] + $spec.files do |f|
  sh "gem build #{$spec.name}.gemspec"
  mv File.basename(f.name), f.name
end

file package('.tar.gz') => %w[pkg/] + $spec.files do |f|
  cmd = <<-SH
    git archive \
      --prefix=#{$spec.name}-#{$spec.version}/ \
      --format=tar \
      HEAD | gzip > #{f.name}
  SH
  sh cmd.gsub(/ +/, ' ')
end

desc 'Publish gem and tarball to rubyforge'
task 'release' => [package('.gem'), package('.tar.gz')] do |t|
  sh "gem push #{package('.gem')}"
end
