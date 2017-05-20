class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def set_params
    if logged_in?
      @user = current_user
      @users = User.all.page(params[:page])
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
