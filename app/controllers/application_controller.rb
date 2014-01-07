class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    rescue_from CanCan::AccessDenied do
        redirect_to new_user_session_url, :alert => '请登陆后访问'
    end

    def require_login
        unless user_signed_in?
            flash[:alert] = '登陆后才能访问此页面';
            redirect_to new_user_session_url
        end
    end
end
