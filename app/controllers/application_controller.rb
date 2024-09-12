class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include CanCan::ControllerAdditions

  def after_sign_in_path_for(resource)
    root_path # or any other path you prefer
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to access this page."
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirects to the login page
  end

end
