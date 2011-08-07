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

module System
  def sys(cmd, *flags)
    fail_ok = flags.include? :fail_ok
    quiet = flags.include? :quiet
    puts ">> #{cmd}" unless quiet
    result = `#{cmd}`
    raise "#{cmd} failed with exit status #{$?.exitstatus}" unless $?.success? || fail_ok
    result.chomp
  end

  def find_git
    dirs = ["", "/opt/local/bin/", "/usr/local/bin/", "/usr/bin/"]
    dirs.each do |dir|
      file = dir + "git"
      if File.exist?(file)
        return file
      end
    end
    raise "Couldn't find git in #{dirs.inspect}"
  end

  def git(cmd, *flags)
    flags << :fail_ok  # why?
    bin = @git_bin || find_git
    sys("#{bin} #{cmd}", *flags)
  end
  
  def git_clean?
    out = git("status --porcelain", :quiet)
    out.strip == ""
  end
  
  def git_branch
    git("branch").split.last
  end

  def heroku(cmd)
    sys("heroku #{cmd}")
  end

  def timed(msg)
    start =Time.now
    puts "#{msg} starting"
    yield
    dur = Time.now - start
    puts "#{msg} took %d:%02d" % [dur / 60, dur % 60]
  end
end

task :tag do
  include System
  unless git_clean?
    warn "Can't tag an unclean git repo."
    puts git( "status --short")
    exit 1
  end
  git "tag --force v#{$spec.version}", false
end

desc 'Tag and publish gem to rubygems'
task 'release' => [package('.gem'), package('.tar.gz'), :tag] do
  sh "gem push #{package('.gem')}"
end
