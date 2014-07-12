# Testify creates class and test files

The idea is to lower the barrier just a bit to doing TDD when writing small scripts.

I'd be surprised if there weren't good alternatives out there already. And no, "use an IDE" isn't one of them. If god had meant us to use an IDE, he wouldn't have given us vim.

## To use:

    testify some_new_filename

This creates two new files:

    lib/some_new_filename.rb
    spec/lib/some_new_filename_spec.rb

And the files are populated:

    % cat lib/some_new_filename.rb 
    class SomeNewFilename
    end

    % cat spec/lib/some_new_filename_spec.rb 
    require "lib/some_new_filename"
    
    describe SomeNewFilename do
    end

Testify won't write over existing files.

Testify creates directories under lib if they don't already exist:

    testify some/path/foo_bar.rb

creates

    lib/some/path/foo_bar.rb
    spec/lib/some/path/foo_bar_spec.rb
 
 There is a shorter version of the command:

   ty some_new_filename

## To install:

    gem install testify
