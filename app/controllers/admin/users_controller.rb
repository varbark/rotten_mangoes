class Admin::UsersController < ApplicationController
  before_filter :restrict_access
  before_filter :only_admin_access
  def index
    @users = User.all
    @user_pages = @users.page(params[:page])
  end
end
