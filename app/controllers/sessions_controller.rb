class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.find_by(email: params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
		log_in user
    # remember user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
		redirect_to user
		# Log the use rin and redirect to the user's show page.
	else
		# Create an error message
		flash.now[:danger] = 'invalid email/password combination' # Not quite right!
		render 'new'
	end
  end

  def destroy
	log_out if logged_in?
    redirect_to root_path
  end
end
