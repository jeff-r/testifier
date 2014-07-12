require "testifier/version"

Gem::Specification.new do |s|
  s.name        = "testifier"
  s.version     = Testifier::VERSION
  s.summary     = "Test file and class file creator"
  s.description = "Creates test and class files"
  s.authors     = ["Jeff Roush"]
  s.email       = "jeff@jeffroush.com"
  s.homepage    = "https://github.com/jeff-r/testify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_development_dependency "rspec"
end
