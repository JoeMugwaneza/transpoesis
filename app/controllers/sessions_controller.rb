class SessionsController < ApplicationController
  def new
   @disable_sidebar = true 
  end

  def create
    @disable_sidebar = true 
    @recent_posts = Post.published.in_order.endmost(5)

    user = User.find_by_email(params[:email])

    if user.enabled == true && user.authenticate(params[:password])

      session[:user_id] = user.id
      
      redirect_to root_url, notice: 'Logged in!'

    elsif user && user.enabled == false

      flash[:warning] = "Your account has be disabled, contact admin for more info"

       render 'new'
    else 

      flash.now.alert = 'Email or password is invalid'
       render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
