class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @user_posts = @user.posts
    @recent_posts = Post.where('review =?', true).in_order.endmost(10)
  end

  def new
    @user = User.new
  end

  def create
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
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    
  end

  def admin
    @table_number = 0    
  end
end
