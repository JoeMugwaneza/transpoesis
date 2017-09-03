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
    redirect_to root_path, alert: "You have no access to the page, You need to sign up or log in to continue." if current_user.nil?
  end

  def authenticate_admin!
    unless current_user && current_user.admin 
      flash[:danger] = "Access Denied"
      redirect_to "/"
    end
  end
end
