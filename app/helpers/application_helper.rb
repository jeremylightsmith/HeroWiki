module ApplicationHelper
  def page(options)
    @page_title = options[:title]
    @page_subtitle = options[:subtitle]
    @page_class = options[:class]
    @page_parent = options[:parent].is_a?(Array) ? options[:parent] : [options[:parent]]
  end

  def subtitle(sub)
    @page_subtitle = sub
  end

  def nav_link(name, url)
    content_tag :li, link_to(name, url), class:(current_page?(url) ? "active" : nil)
  end

  def gravatar_for(user, options = {})
    options = {:alt => 'avatar', :class => 'avatar', :size => 80}.merge! options
    id = Digest::MD5::hexdigest user.email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '.jpg?s=' + options[:size].to_s
    options.delete :size
    image_tag url, options
  end

  def render_errors(record)
    return unless record.errors.any?
    
    render :partial => "shared/errors", :object => record.errors, :locals => {:type => record.class}
  end

  def button_to(name, url, options = {})
    options[:class] = [options[:class], "btn", "btn-mini"].compact.join(" ")
    icon = if options[:icon]
             "<i class='icon-#{options.delete(:icon)}'></i>"
           end

    link_to(raw([icon, name].compact.join(" ")), url, options)
  end
end
