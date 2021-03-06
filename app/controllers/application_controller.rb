class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  include LayoutHelper
  before_filter :init_breadcrumbs
  def init_breadcrumbs
    breadcrumbs.add :home,root_url,:rel=>'nofollow'
  end

end
