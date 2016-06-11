require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to root_path, alert: "Sorry! you were not authorized!" }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, :username, :name)
    }
  end
end
