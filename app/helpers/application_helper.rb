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
  
  def icon(symbol)
    "<span class=\"iconic #{symbol}\"></span>".html_safe
  end

  def error_messages_for(object, attribute)
    if object.errors[attribute].any?
      messages = object.errors[attribute].collect {|value| "#{attribute.to_s.titlecase} #{value}." }.join('<br />')
      "<p class=\"inline-errors\">#{messages}</p>".html_safe
    end
  end
end
