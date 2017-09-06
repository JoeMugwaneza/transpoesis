class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(registration_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      end
    else
      flash[:error] = "Registration Failed, Fill in all the field and try again!"
      redirect_to root_url

    end
  end 


  def update
     @user = current_user
     if @user.update(update_account_params)
        flash[:success] ="Profile Sucessfull updated"
        redirect_to root_url
      else
        flash[:info] = "Something went wrong, try again"
        redirect_to root_url
      end
   end 

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def update_account_params
    params.require(:user).permit(:first_name, :last_name, :profile_picture, :email, :password, :password_confirmation, :current_password, category_ids: [])
  end
end
