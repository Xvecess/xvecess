class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :use_auth_provider

  def facebook
  end

  def twitter
  end

  protected
  def use_auth_provider
    # render json: request.env['omniauth.auth']
    auth = request.env['omniauth.auth']
  # puts  auth.inspect
    @user = User.find_for_oauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success, kind: params[:action].capitalize if is_navigational_format?
    end
  end
end