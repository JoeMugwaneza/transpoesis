class UsersController < ApplicationController
  
  def index
    @users = User.all
    @recent_posts = Post.published.in_order.endmost(5)
  end

  def show
    @user = User.find_by(id: params[:id])
    @user_posts = @user.posts
    @recent_posts = Post.published.in_order.endmost(5)
  end

  def new
    @user = User.new
    render :partial => 'users/signupmodal'
    @categories = Category.all
  end

  def create
    @recent_posts = Post.published.in_order.endmost(5)
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
    
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :profile_picture, :password, :password_confirmation, category_ids: [])
    
  end
end
