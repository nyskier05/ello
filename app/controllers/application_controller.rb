class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :first_name, :last_name,:date_of_birth, :is_female, :height, :church, 
    	:church_status, :neighborhood, :interests, :testimony, :more_info, :dating_pref, :cellphone, :avatar, :status) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :first_name, :last_name, :date_of_birth, :is_female, :height, :church, 
    	:church_status, :neighborhood, :interests, :testimony, :more_info, :dating_pref, :cellphone, :avatar, :status) }
  end
  #Devise::SessionsController.ssl_required :new, :create
end
