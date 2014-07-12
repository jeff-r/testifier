Testify creates class and test files for you.

The idea is to lower the barrier just a bit to doing TDD when writing small scripts.

I'd be surprised if there weren't good alternatives out there already. And no, "use an IDE" isn't one of them. If god had meant us to use an IDE, he wouldn't have given us vim.

How to use:

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

There is a shorter version of the command:

   ty some_new_filename

Testify won't write over existing files.

