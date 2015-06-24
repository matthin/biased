require "./lib/biased/version"

Gem::Specification.new do |s|
  s.name          = "biased"
  s.version       = Biased::VERSION
  s.date          = Date.today.to_s
  s.summary       = "Provides the parent organization of any website, if possible."
  s.authors       = ["Justin Harrison"]
  s.email         = "justin@matthin.com"
  s.files         = Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.executables   = ["biased"]
  s.homepage      = "https://github.com/matthin/biased"
  s.license       = "MIT"
  s.add_runtime_dependency("httparty", "~> 0.13")
  s.add_runtime_dependency("wikipedia-client", "~> 1.3")
end

