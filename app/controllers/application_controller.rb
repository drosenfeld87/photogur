class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    user_id = session[:user_id]
    user_id && User.find(user_id)
  end

  helper_method :current_user

  def ensure_logged_in
    # binding.pry
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end
end
