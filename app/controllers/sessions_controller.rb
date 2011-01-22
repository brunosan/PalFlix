class SessionsController < ApplicationController
  def new
     @title = "Sign in"
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
 def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      current_user.touch
      redirect_back_or movies_path
      
    end
  end


end
