class SessionsController < ApplicationController
 
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])

  	if user.nil?
  		flash[:error] = "Invalid email or password"
  	else
  		session[:user_id] = user.id
    end
    redirect_to :back
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to '/'
  end
end
