class ApplicationController < ActionController::Base
  before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # For user sign up (optional)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tag_list])

    # For user update (account update)
    devise_parameter_sanitizer.permit(:account_update, keys: [:tag_list])
  end
end
