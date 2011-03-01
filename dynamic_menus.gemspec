# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dynamic_menus/version"

Gem::Specification.new do |s|
  s.name        = "dynamic_menus"
  s.version     = DynamicMenus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sandro Duarte"]
  s.email       = ["sandrods@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{generate tree-based menus}
  s.description = %q{generate tree-based menus}

  s.rubyforge_project = "dynamic_menus"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("rubytree", "~> 0.8.1")
end
