class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "Signed in successfully."
      user_path(current_user.id)
    end
  end

  def after_sign_up_path_for(resource)
    if current_user
      flash[:notice] = "Welcome! You have signed up successfully."
    end
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    if current_user
      flash[:notice] = "Signed out successfully."
    end
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end

end