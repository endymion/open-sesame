require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "open-sesame"
  gem.homepage = "http://www.ryanalynporter.com/2009/06/25/authorizing-users-between-web-sites-with-open-sesame/"
  gem.license = "MIT"
  gem.summary = %Q{Send authorized traffic from one web site to another with a cryptographic authorization token.}
  gem.description = %Q{Use a time-sensitive cryptographic token based on a shared secret phrase to generate an authorization token for passing traffic from one web site to another.}
  gem.authors = ["Ryan Alyn Porter"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
desc "Run specs"
RSpec::Core::RakeTask.new

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/*.rb']
end