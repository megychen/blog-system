module PostsHelper
  def render_post_status(post)
    if post.status == "draft"
      content_tag(:span, " ", :class => "fa fa-pencil-square-o")
    elsif post.status == "public"
      content_tag(:span, " ", :class => "fa fa-globe")
    else
      content_tag(:span, " ", :class => "fa fa-lock")
    end
  end
end
