class SessionsController < ApplicationController
  def new
  end

  def create
    if admin_user?
      session[:user_id_2] = params[:user_id] 
      return redirect_to movies_path
    end

    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path
    else
      flash.now[:alert] = "Log in failed....." # The old fashion way
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end
  
end
