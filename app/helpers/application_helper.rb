module ApplicationHelper
  def markdown(text)
    begin
      render_options = {
        hard_wrap: true,
        link_attributes: { target: "_blank" }
      }

      markdown_options = {
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        autolink: true,
        tables: true,
        strikethrough: true,
        lax_html_blocks: true,
        superscript: true,
        highlight: true,
        quote: true
      }
      renderer = Redcarpet::Render::HTML.new(render_options)
      markdown_to_html = Redcarpet::Markdown.new(renderer, markdown_options)
      markdown_to_html.render(text).html_safe
    rescue StandardError
      flash.alert = 'Unable to render Markdown!'
      text
    end
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=400"
  end
end
