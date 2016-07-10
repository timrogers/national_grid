require "rbconfig"
require "fileutils"

module OSTN02C
  module_function

  def make
    compile and package
  end

  def compile
    puts "Compiling libostn02"
    FileUtils.mkdir_p object_path
    Dir.chdir object_path do
      run RbConfig.expand("$(CC) -std=gnu99 -I#{include_path} $(CPPFLAGS) $(CFLAGS) -c #{sources.join(" ")}")
    end
  end

  def package
    puts "Packaging libostn02"
    FileUtils.mkdir_p lib_path
    run RbConfig.expand("$(AR) -crsv #{library} #{objects}")
  end

  def sources
    Dir.glob(File.join(include_path, "*.c"))
  end

  def objects
    File.join(object_path, "*.o")
  end

  def library
    File.join(lib_path, "libostn02.a")
  end

  def include_path
    File.expand_path("ostn02c/OSTN02", __dir__)
  end

  def lib_path
    File.join(output_path, "lib")
  end

  def object_path
    File.join(output_path, "obj")
  end

  def output_path
    File.expand_path("../tmp/ostn02c", __dir__)
  end

  def run(command)
    puts command
    system command
  end
end
