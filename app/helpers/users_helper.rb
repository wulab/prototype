module UsersHelper
  def gravatar_for(user, options = {:size => 50})
    gravatar_image_tag(
      user.email.downcase,
      :alt => user.name,
      :class => "gravatar",
      :gravatar => options
    )
  end
  
  def image_url(source)
    "http://#{deployed_host_with_port}#{image_path(source)}"
  end
end
