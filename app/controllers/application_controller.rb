class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.admin === true
      request.env['omniauth.origin'] || admin_index_path || root_path
    else
      request.env['omniauth.origin'] || dashboard_users_path || root_path
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, 
        :password, :password_confirmation, :first_name, :last_name) }
    end

end
