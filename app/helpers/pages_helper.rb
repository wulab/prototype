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
    if no_project_selected?
      logo_text = link_to("Company name", root_path)
    else
      logo_text = @project.name
    end
    content_tag(:h1, logo_text, :id => "logo")
  end
  
  def icon(symbol)
    "<span class=\"iconic #{symbol}\"></span>".html_safe
  end
  
  def image_url(source)
    "http://#{deployed_host_with_port}#{image_path(source)}"
  end
  
end
