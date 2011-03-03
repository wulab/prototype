module UsersHelper
  def gravatar_for(user, options = {:size => 50})
    gravatar_image_tag(
      user.email.downcase,
      :alt => user.name,
      :class => "gravatar",
      :gravatar => options
    )
  end
  
  def deployed_host_with_port
    if request.env["HTTP_X_FORWARDED_FOR"]
      referer = URI.parse(request.referer)
      (referer.port == 80) ? referer.host : "#{referer.host}:#{referer.port}"
    else
      request.host_with_port
    end
  end
  
  def image_url(source)
    "http://#{deployed_host_with_port}#{image_path(source)}"
  end
end
