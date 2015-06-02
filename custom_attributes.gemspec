$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "custom_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "custom_attributes"
  s.version     = CustomAttributes::VERSION
  s.authors     = ["Tariq Hussain"]
  s.email       = ["tariq.hussain@7vals.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CustomAttributes."
  s.description = "TODO: Description of CustomAttributes."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency "sqlite3"
end
