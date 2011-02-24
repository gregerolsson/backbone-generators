# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "backbone-generators/version"

Gem::Specification.new do |s|
  s.name        = "backbone-generators"
  s.version     = Backbone::Generators::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Greger Olsson"]
  s.email       = ["greger.olsson@redstone.se"]
  s.homepage    = ""
  s.summary     = %q{Backbone.js class generators}
  s.description = %q{Generates Backbone.Model, Backbone.Collection, Backbone.Controller, and Backbone.View classes}

  s.rubyforge_project = "backbone-generators"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
