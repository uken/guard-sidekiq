# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/sidekiq/version"

Gem::Specification.new do |s|
  s.name        = "guard-sidekiq"
  s.version     = Guard::SidekiqVersion::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mark Bolusmjak", "pitr"]
  s.email       = ["team@uken.com"]
  s.homepage    = 'http://github.com/uken/guard-sidekiq'
  s.summary     = %q{guard gem for sidekiq}
  s.description = %q{Guard::Sidekiq automatically starts/stops/restarts sidekiq worker}

  s.add_dependency 'guard', '>= 1.1'
  s.add_dependency 'sidekiq'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',         '~> 2.5.0'
  s.add_development_dependency 'guard-rspec',   '>= 0.2.0'
  s.add_development_dependency 'guard-bundler', '>= 0.1.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
