class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def restrict_access
      if !current_user
        flash[:alert] = "You must log in first!"
        redirect_to new_session_path
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def admin_user?
      session[:admin]
    end

    def only_admin_access
      if !admin_user?
        flash[:alert] = 'You are not Admin! Get out of here!'
        redirect_to root_path
      end
    end

    def admin_switch_to_another_user?
      if session[:admin] != current_user.admin
        true
      else
        false
      end
    end

    helper_method :current_user
    helper_method :admin_user?
    helper_method :admin_switch_to_another_user?
    helper_method :another_user
end
