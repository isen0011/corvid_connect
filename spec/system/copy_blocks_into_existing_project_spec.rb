require_relative "../spec_helper"

RSpec.describe "Copy blocks into existing project" do
  let(:source_project_file_name) { "spec/fixtures/source_project.lmsp" }
  let(:destination_project_original_file_name) { "spec/fixtures/destination_project_original.lmsp" }
  let(:destination_project_file_name) { "spec/fixtures/destination_project.lmsp" }
  let(:destination_final_state) { "spec/fixtures/destination_final_state.lmsp" }

  before(:each) do
    FileUtils.cp(destination_project_original_file_name, destination_project_file_name)
  end

  it "copies a block from one project into another" do
#    CorvidConnect.copy_block(source_project_file_name, destination_project_file_name, "Sample Block Name")
    expect(destination_project_file_name).to be_same_file_as(destination_final_state)
  end
end
