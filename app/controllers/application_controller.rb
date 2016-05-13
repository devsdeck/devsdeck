class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to root_path, alert: 'Sorry! you were not authorized!' }
    end
  end
end
