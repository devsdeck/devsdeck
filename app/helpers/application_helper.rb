module ApplicationHelper
  def markdown(text)
    begin
      options = {
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        autolink: true,
        strikethrough: true,
        lax_html_blocks: true,
        superscript: true,
        highlight: true,
        quote: true
      }
      markdown_to_html = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
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
