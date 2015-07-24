class UsersController < ActionController::API
  include UsersHelper

  # creates user and directs to send verification code page
  # otherwise redirects home
  def create
    p params
    @user = User.find_or_initialize_by(email: params[:email])
    p "user found is: "
    p @user
    @user.update_attributes(password_hash: params[:password])
    p "updated user: "
    p @user
    @user.password = params[:password]
    if @user.save
      set_session
      p "here's the session" * 5
      p session[:user_id]
      p "here's the new user" * 5
      p @user
      data = { status: "success", id: @user.id }
      # make new session here
      render :json => data
    else
      render :json => { status: "error", error: "User failed to save. Please make sure your email is not already in use."}
    end
  end
end
