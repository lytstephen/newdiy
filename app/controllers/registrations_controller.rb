class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :password, :current_password,
        :password_confirmation, :first_name, :last_name,
        :phone, :shipping_add1, :shipping_add2,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:email, :password, :current_password,
        :password_confirmation, :first_name, :last_name,
        :phone, :shipping_add1, :shipping_add2,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country)
      end
    end

    def after_update_path_for(resource)
      edit_user_registration_path
    end

end