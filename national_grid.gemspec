lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "national_grid/version"

Gem::Specification.new do |spec|
  spec.name          = "national_grid"
  spec.version       = NationalGrid::VERSION
  spec.authors       = ["Andrew Haines"]
  spec.email         = ["andrew@haines.org.nz"]
  spec.summary       = "Converts between Ordnance Survey National Grid easting-northing coordinates and GPS latitude-longitude coordinates"
  spec.homepage      = "https://github.com/haines/national_grid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest", "~> 5.3"
end
