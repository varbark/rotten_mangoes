class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:another_user_id]
      session[:user_id] = params[:another_user_id] 
      return redirect_to movies_path
    end

    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_user.admin
        session[:admin] ||= current_user.admin  
      end
      redirect_to movies_path
    else
      flash.now[:alert] = "Log in failed....." # The old fashion way
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    if session[:admin] 
      session[:user_id_2] = nil
    end
    redirect_to movies_path, notice: "Adios!"
  end
  
end
