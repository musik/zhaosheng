module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  def filter_url_for options = {}
    @curren_params ||= begin
                         tmp = params.clone
                         tmp.keep_if{|k,v| %w(duixiang leibie moshi name school_name).include? k}
                         #if tmp["q"].present?
                           #tmp["q"].reject!{|k,v| %w(duixiang_eq leibie_eq moshi_eq).include? k}
                         #end
                         tmp
                       end
    #url_for(@curren_params.merge(options).merge(:page=>nil,:commit=>nil))
    url_for(@curren_params.merge(options))
  end

end
