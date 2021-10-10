require_relative "../spec_helper"

RSpec.describe CorvidConnect do
  context "copy_blocks" do
    let(:source)        { "source_file" }
    let(:dest)          { "destination_file" }
    let(:proj_gen_stub) { class_double(Project) }
    let(:source_stub)   { instance_double(Project) }
    let(:dest_stub)     { instance_double(Project) }
    let(:blocks)        { "json_representation_of_blocks" }
    before do
      allow(proj_gen_stub).to receive(:new).with(file: source).and_return(source_stub)
      allow(proj_gen_stub).to receive(:new).with(file: dest).and_return(dest_stub)
      allow(source_stub).to receive(:extract_blocks).and_return(blocks)
      allow(dest_stub).to receive(:add_blocks).with(blocks: blocks)
      allow(dest_stub).to receive(:save_changes)
    end

    it "instantiates two Projects" do
      expect(proj_gen_stub).to receive(:new).with(file: source)
      expect(proj_gen_stub).to receive(:new).with(file: dest)
      CorvidConnect.copy_blocks(source: source, destination: dest, project_generator: proj_gen_stub)
    end

    it "calls extract blocks on source" do
      expect(source_stub).to receive(:extract_blocks)
      CorvidConnect.copy_blocks(source: source, destination: dest, project_generator: proj_gen_stub)
    end

    it "adds the extracted blocks to dest" do
      expect(dest_stub).to receive(:add_blocks).with(blocks: blocks)
      CorvidConnect.copy_blocks(source: source, destination: dest, project_generator: proj_gen_stub)
    end

    it "saves the dest projected" do
      expect(dest_stub).to receive(:save_changes)
      CorvidConnect.copy_blocks(source: source, destination: dest, project_generator: proj_gen_stub)
    end
  end
end
