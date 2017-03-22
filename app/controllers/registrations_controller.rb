# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    super
  end

  def create
    super
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @user = User.find(current_user.id)

    successfully_updated = if account_update_params[:password].blank?
                             params[:user].delete(:current_password)
                             @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
                           else
                             @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
                           end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      if params[:user][:image].present?
        render "crop"
      else
        redirect_to "/users/edit"
      end
    else
      render "edit"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_crop_x, :profile_crop_y, :profile_crop_w, :profile_crop_h, :profile, :first_name, :last_name])
  end

end