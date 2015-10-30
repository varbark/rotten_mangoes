class Admin::UsersController < ApplicationController
  before_filter :restrict_access
  before_filter :only_admin_access
  def index
    @users = User.order(:firstname).page(params[:page]).per(1)
  end
end
