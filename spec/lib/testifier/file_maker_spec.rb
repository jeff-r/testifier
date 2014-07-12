require "testifier/file_maker"

module Testifier
  describe FileMaker do
    let(:file1) { "maketest/foo" }
    let(:maker) { FileMaker.new(file1) }
    let(:mock_class_file) { double("file") }
    let(:mock_test_file) { double("file") }

    before do
      allow(Dir).to receive(:mkdir)
      allow(File).to receive(:exist?)
      allow(File).to receive(:open).with(maker.class_file, anything).and_yield(mock_class_file)
      allow(File).to receive(:open).with(maker.test_file, anything).and_yield(mock_test_file)
      allow(mock_class_file).to receive(:puts)
      allow(mock_test_file).to receive(:puts)
      allow(maker).to receive(:puts)
    end

    it "ignores the file suffix when creating new files" do
      expect(FileMaker.new("whatever.txt").class_file).to eql("lib/whatever.rb")
    end

    it "gets the class file name from the passed path" do
      expect(maker.class_file).to eql("lib/maketest/foo.rb")
    end

    it "gets the test file name from the passed path" do
      expect(maker.test_file).to eql("spec/lib/maketest/foo_spec.rb")
    end

    it "gets the file basename from the passed path" do
      expect(maker.basename).to eql("foo")
    end

    it "returns the target directory" do
      expect(maker.target_dir).to eql("lib/maketest/")
    end

    it "returns the test directory" do
      expect(maker.test_dir).to eql("spec/lib/maketest/")
    end

    describe "#create_files" do
      it "creates the target dir if needed" do
        allow(File).to receive(:exist?).with(maker.target_dir).and_return(false)
        expect(Dir).to receive(:mkdir).with(maker.target_dir)
        maker.create_files
      end

      it "doesn't create the target dir if not needed" do
        allow(File).to receive(:exist?).with(maker.target_dir).and_return(true)
        expect(Dir).to_not receive(:mkdir).with(maker.target_dir)
        maker.create_files
      end

      it "creates the test dir if needed" do
        allow(File).to receive(:exist?).with(maker.test_dir).and_return(false)
        expect(Dir).to receive(:mkdir).with(maker.test_dir)
        maker.create_files
      end
    end

    describe "#class_definition" do
      it "includes the class name" do
        maker = FileMaker.new("some_class_name")
        expect(maker.class_definition).to include("class SomeClassName")
      end
    end

    describe "#test_definition" do
      it "includes the class name" do
        maker = FileMaker.new("some_class_name")
        expect(maker.test_definition).to include("describe SomeClassName")
      end
    end

    describe "#create_class_file" do
      it "creates the class file" do
        allow(File).to receive(:exist?).and_return(false)
        expect(mock_class_file).to receive(:puts).with(maker.class_definition)
        maker.create_class_file
      end

      it "doesn't overwrite an existing class file" do
        allow(File).to receive(:exist?).and_return(true)
        expect(mock_class_file).to_not receive(:puts).with(maker.class_definition)
        maker.create_class_file
      end
    end

    describe "#create_spec_file" do
      it "doesn't overwrite an existing spec file" do
        allow(File).to receive(:exist?).and_return(true)
        expect(mock_test_file).to_not receive(:puts).with(maker.test_definition)
        maker.create_test_file
      end

      it "creates the spec file" do
        allow(File).to receive(:exist?).and_return(false)
        expect(mock_test_file).to receive(:puts).with(maker.test_definition)
        maker.create_test_file
      end
    end
  end
end
