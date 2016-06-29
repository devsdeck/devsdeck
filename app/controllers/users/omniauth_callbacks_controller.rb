class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_github_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_session_url,
        alert: "Sorry! Something went wrong and we couldn't log you in with your Github account."
    end
  end

  def failure
    redirect_to root_path
  end
end
