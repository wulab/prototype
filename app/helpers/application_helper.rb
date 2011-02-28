module ApplicationHelper
  def title
    base_title = "Project Management App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    text_logo = "Company name"
    if @project.nil?
      content_tag(:h1, link_to(text_logo, root_path), :id => "logo")
    else
      @project.name
    end
  end

end
