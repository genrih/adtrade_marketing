$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adtrade_marketing/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adtrade_marketing"
  s.version     = AdtradeMarketing::VERSION
  s.authors     = ["adtrade"]
  s.email       = ["support@adtrade.com"]
  s.homepage    = "TODO"
  s.summary     = "Marketing for adtrade.com"
  s.description = "Marketing for adtrade.com"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '>= 4.0'

  s.add_development_dependency "sqlite3"
end
