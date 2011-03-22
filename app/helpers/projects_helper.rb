module ProjectsHelper
  def in_a_project?
    !@project.nil? && !@project.new_record?
  end
  
end
