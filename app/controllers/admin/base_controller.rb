class Admin::BaseController < ApplicationController
    layout 'admin'
    before_filter :authenticate_user!
    before_filter :set_current_user

    rescue_from CanCan::AccessDenied do
        redirect_to root_url, :alert => '没有权限访问这个页面'
    end

    def set_current_user
        User.current = current_user
    end
end
