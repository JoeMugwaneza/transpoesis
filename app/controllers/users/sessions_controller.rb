class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def new
   @disable_sidebar = true 
  @recent_posts = Post.published.in_order.endmost(5)
  redirect_to root_url
  end

  def create
    super
    @disable_sidebar = true 
    @recent_posts = Post.published.in_order.endmost(5)


    user = User.find_for_database_authentication(email: params[:email])

    if user && user.valid_password?(params[:user][:password]) && user.enabled == true

      session[:user_id] = user.id

      if user.admin == true
        redirect_to authorize_personel_path, notice: "Welcome back Admin!"
      else
        redirect_to root_url, notice: 'Logged in!'
      end

    elsif user && user.enabled == false

      flash[:warning] = "Your account has be disabled, contact admin for more info"

       redirect_to root_url
    else 

      flash[:info] = 'Email or password is invalid'
       redirect_to root_url
    end

  end

  def destroy
    super 
    if resource.destroy
      redirect_to root_url, notice: 'Logged out! badly'
    end
  end
end
