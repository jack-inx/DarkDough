class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected

  def layout_by_resource
    if devise_controller?
      "public"
    else
      "application"
    end
  end
end
