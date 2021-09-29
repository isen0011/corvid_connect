require_relative "../spec_helper"

RSpec.describe CorvidConnect do
  context "copy_block" do
    let(:source)        { "source_file" }
    let(:dest)          { "destination_file" }
    let(:block_name)    { "some_block" }
    let(:proj_gen_stub) { class_double(Project) }
    let(:source_stub)   { instance_double(Project) }
    let(:dest_stub)     { instance_double(Project) }
    let(:block)         { "json_representation_of_a_block" }
    before do
      allow(proj_gen_stub).to receive(:new).with(file: source).and_return(source_stub)
      allow(proj_gen_stub).to receive(:new).with(file: dest).and_return(dest_stub)
      allow(source_stub).to receive(:extract_block).with(block: block_name).and_return(block)
      allow(dest_stub).to receive(:add_block).with(block: block)
    end

    it "instantiates two Projects" do
      expect(proj_gen_stub).to receive(:new).with(file: source)
      expect(proj_gen_stub).to receive(:new).with(file: dest)
      CorvidConnect.copy_block(source: source, destination: dest, block: block_name, project_generator: proj_gen_stub)
    end

    it "calls extract block on source" do
      expect(source_stub).to receive(:extract_block).with(block: block_name)
      CorvidConnect.copy_block(source: source, destination: dest, block: block_name, project_generator: proj_gen_stub)
    end

    it "adds the extracted block to dest" do
      expect(dest_stub).to receive(:add_block).with(block: block)
      CorvidConnect.copy_block(source: source, destination: dest, block: block_name, project_generator: proj_gen_stub)
    end
  end
end
