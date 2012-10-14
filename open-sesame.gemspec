# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "open-sesame"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Alyn Porter"]
  s.date = "2012-10-14"
  s.description = "Use a time-sensitive cryptographic token based on a shared secret phrase to generate an authorization token for passing traffic from one web site to another."
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "init.rb",
    "install.rb",
    "lib/open-sesame.rb",
    "open-sesame.gemspec",
    "spec/open-sesame_spec.rb",
    "spec/spec_helper.rb",
    "uninstall.rb"
  ]
  s.homepage = "http://www.ryanalynporter.com/2009/06/25/authorizing-users-between-web-sites-with-open-sesame/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Send authorized traffic from one web site to another with a cryptographic authorization token."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.6.4"])
      s.add_development_dependency(%q<yard>, ["~> 0.8.2.1"])
      s.add_development_dependency(%q<redcarpet>, ["~> 2.1.1"])
      s.add_development_dependency(%q<delorean>, ["~> 2.0.0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<simplecov>, ["~> 0.6.4"])
      s.add_dependency(%q<yard>, ["~> 0.8.2.1"])
      s.add_dependency(%q<redcarpet>, ["~> 2.1.1"])
      s.add_dependency(%q<delorean>, ["~> 2.0.0"])
      s.add_dependency(%q<debugger>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<simplecov>, ["~> 0.6.4"])
    s.add_dependency(%q<yard>, ["~> 0.8.2.1"])
    s.add_dependency(%q<redcarpet>, ["~> 2.1.1"])
    s.add_dependency(%q<delorean>, ["~> 2.0.0"])
    s.add_dependency(%q<debugger>, [">= 0"])
  end
end

