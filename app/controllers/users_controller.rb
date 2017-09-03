class UsersController < ApplicationController
  
  def index
    @users = User.all
    @user = User.new
    @recent_posts = Post.published.in_order.endmost(5)
    
    user = User.find_by(id: params[:disable])
    
    if params[:disable] && user 
      user.enabled = !user.enabled
      user.save
      flash[:sucess] = "#{user.last_name} status changed"
      redirect_to authorize_personel_path
    end
  end
  def show
    @user = User.find_by(id: params[:id])
    @user_posts = @user.posts
    @recent_posts = Post.published.in_order.endmost(5)
  end

  def new
    @disable_sidebar = true

    @user = User.new
    @categories = Category.all
  end

  def create
    @disable_sidebar = true
    @recent_posts = Post.published.in_order.endmost(5)
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      redirect_to root_url
    end
    
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :profile_picture, :password, :password_confirmation, category_ids: [])
    
  end

  def admin
    @recent_posts = Post.published.in_order.endmost(5)
    
  end
end
