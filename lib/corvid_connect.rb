require_relative "project"

class CorvidConnect
  def self.copy_block(source:, destination:, block:, project_generator: Project)
    source_project = project_generator.new(file: source)
    destination_project = project_generator.new(file: destination)
    destination_project.add_block(block: source_project.extract_block(block: block))
    destination_project.save_changes
    # unzip source & internal scratch file
    # extract block
    # unzip destination & internal scratch file
    # add block to project.json
    # re-zip destination
  end
end
