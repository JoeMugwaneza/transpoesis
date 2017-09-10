class UsersController < ApplicationController
  
  before_action :authorize_user!, except: [:index]
  before_action :correct_user,   only: [:edit, :update]
  def index
    @users = User.all
    @recent_posts = Post.published.in_order.endmost(5)
    
    user = User.find_by(id: params[:disable])
    
    if params[:disable] && user 
      user.enabled = !user.enabled


      if user.enabled == true
        user.save

        flash[:info] = "#{user.last_name} is active now"
        redirect_to authorize_personel_path

      elsif user.enabled == false
        user.save
        
        flash[:info] = "#{user.last_name} is blocked"
        redirect_to authorize_personel_path
      end
    end
  end

    # end
    #   user.save
    #   flash[:sucess] = "#{user.last_name} status changed"
    #   redirect_to authorize_personel_path
    # end
  # end
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

  def edit
    @recent_posts = Post.published.in_order.endmost(5)
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(update_account_params)
      flash[:sucess] = "Profile updated"
      redirect_to root_url
    else
      flash[:info] = "Something went wrong, try again"
      redirect_to root_url
    end

  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :profile_picture, :password, :password_confirmation, category_ids: [])
    
  end


  def update_account_params
    params.require(:user).permit(:first_name, :last_name, :profile_picture, :email, :password, :password_confirmation, :current_password, category_ids: [])
  end

  def admin
    @recent_posts = Post.published.in_order.endmost(5)
    
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
