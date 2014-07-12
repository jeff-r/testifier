require "active_support/all"
require "fileutils"

module Testifier
  class FileMaker
    def initialize(path)
      @initial_path =  path
    end

    def target_dir
      "lib/#{dirname}"
    end

    def test_dir
      "spec/lib/#{dirname}"
    end

    def class_file
      "lib/#{dirname}#{basename}.rb"
    end

    def test_file
      "spec/lib/#{dirname}#{basename}_spec.rb"
    end

    def basename
      File.basename(@initial_path, File.extname(@initial_path))
    end

    def create_files
      make_dir_if_necessary(target_dir)
      make_dir_if_necessary(test_dir)
      create_class_file
      create_test_file
    end

    def create_class_file
      unless File.exist?(class_file)
        puts "creating #{class_file}"
        File.open(class_file, "w") { |file| file.puts class_definition }
      end
    end

    def create_test_file
      unless File.exist?(test_file)
        puts "creating #{test_file}"
        File.open(test_file, "w") { |file| file.puts test_definition }
      end
    end

    def class_definition
      <<-CLASS
class #{class_name}
end
CLASS
    end

    def test_definition
      <<-TEST
require "#{dirname}#{basename}"

describe #{class_name} do
end
TEST
    end

    private

    def class_name
      basename.camelize
    end

    def make_dir_if_necessary(filename)
      unless File.exist?(filename)
        FileUtils.mkdir_p(filename)
      end
    end

    def dirname
      dir = "#{File.dirname(@initial_path)}/"
      dir == "./" ? "" : dir
    end
  end
end
