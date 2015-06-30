class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def remote_user
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.remote_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
