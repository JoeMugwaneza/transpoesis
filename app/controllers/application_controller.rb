class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def find_user
    @user = User.find_by(id: params[:id])
  end
  private

  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :user

  def authorize_user!
    redirect_to root_path, alert: "Not authorized, in order to have access to a full Poem or want to create one, just click Join to sign in or up" if current_user.nil?
  end
end
