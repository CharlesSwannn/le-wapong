class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def default_url_options
    { host: ENV["www.lewapong.fun"] || "localhost:3000" }
  end

  protected

  def after_sign_in_path_for(resource_or_scope)
    if session[:attendee]
      previous_url = session[:previous_url]
      session[:previous_url] = nil #clear session
      previous_url #going back to event page
    else
      super
    end
  end
end
