module ProjectsHelper
  def no_project_selected?
    @project.nil? || @project.new_record?
  end
  
end
