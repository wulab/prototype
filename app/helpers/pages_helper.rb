module PagesHelper
  def title
    base_title = "Project Management App"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
  
  def logo
    if in_a_project?
      logo_text = @project.name
    else
      logo_text = link_to("Company name", root_path)
    end
    content_tag(:h1, logo_text, :id => "logo")
  end
  
  def icon(symbol)
    "<span class=\"iconic #{symbol}\"></span>".html_safe
  end
  
end
