$spec = Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'whos'
  s.version = '0.1.2'

  s.description = "Wraps whois and removes the BS"
  s.summary     = "Wraps whois and removes the registrar legal/marketing spam from the response."

  s.authors = ["Alex Chaffee"]
  s.email = "alex@stinky.com"

  s.files = %w[
    README.md
    LICENSE
    Rakefile
    whos.gemspec
    bin/whos] + Dir.glob("lib/**/*.rb")
  s.executables = ['whos']
  s.test_files = s.files.select {|path| path =~ /^spec\/.*_spec.rb/}

  s.extra_rdoc_files = %w[README.md]
  #s.add_dependency 'rack',    '>= 0.9.1'
  #s.add_dependency 'launchy', '>= 0.3.3', '< 1.0'

  s.homepage = "http://github.com/alexch/whos/"
  s.require_paths = %w[lib]
  s.rubygems_version = '1.1.1'
end
