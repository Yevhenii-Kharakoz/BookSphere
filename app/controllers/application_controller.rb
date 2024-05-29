class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city, :phone_number, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :city, :phone_number, :age])
  end
end

class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    elsif session[:locale]
      I18n.locale = session[:locale]
    else
      I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge(options)
  end
end


