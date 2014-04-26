lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "national_grid/version"

module Files
  module_function

  def all
    git_files + git_submodule_files
  end

  def git_files(dir = ".")
    Dir.chdir File.expand_path(dir, __dir__) do
      `git ls-files -z`.split("\x0")
    end
  end

  def git_submodules
    `git submodule -q foreach 'printf "$path\\0"'`.split("\x0")
  end

  def git_submodule_files
    git_submodules.flat_map {|submodule|
      git_files(submodule).map {|file| File.join(submodule, file)}
    }
  end
end

Gem::Specification.new do |spec|
  spec.name          = "national_grid"
  spec.version       = NationalGrid::VERSION
  spec.authors       = ["Andrew Haines"]
  spec.email         = ["andrew@haines.org.nz"]
  spec.summary       = "Converts between Ordnance Survey National Grid easting-northing coordinates and GPS latitude-longitude coordinates"
  spec.homepage      = "https://github.com/haines/national_grid"
  spec.license       = "MIT"

  spec.files         = Files.all
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/national_grid/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest", "~> 5.3"
end
