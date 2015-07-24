class SessionsController < ActionController::API
  include UsersHelper
  # GET request
  # fetches user id if client has user_id in cookie
  def new
    if current_session?
      p "there is a session"
      current_user
      p @user
      p response = { status: "success", id: @user.id }
      render :json => response
    else
      p "no current session"
      p response = { status: "error", error: "User does not have an active session." }
      render :json => response
    end
  end

  # POST request aliased as '/login'
  # creates a session
  # redirects to send message on successful login; redirect home otherwise
  def create
    p "login session"
    p session[:user_id]
    @user = User.find_by(email: params[:email])
    p params
    p "attempting login with user" * 5
    p @user
    set_session
    p session[:user_id]
    if @user && @user.password == params[:password]
      response = { status: "success", id: @user.id, session_id: session[:user_id] }
      render :json => response
    else
      response = {status: "error", error: "user not found, login failed"}
      render :json => response
    end
  end

  def destroy
    p "leaving session #" << session[:user_id]
    logout_user if current_session?
    p "logged out, current session: "
    p session
  end
end
