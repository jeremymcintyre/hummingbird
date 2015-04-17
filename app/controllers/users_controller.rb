class UsersController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def index
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    render :json => "APIs don't have index pages"
  end

  def show
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    user = User.find(1)
    if user.nil?
      render :json => "No users here."
    else
      render :json => "Found the user."
    end
  end

  def create
    p params
    @user = User.find_or_initialize_by(email: params[:email])
    @user.update_attributes(password_hash: params[:password])
    @user.password = params[:password]
    if @user.save
      set_session
      p "here's the session" * 5
      p session
      p "here's the new user" * 5
      p @user
      data = { id: @user.id }
      render :json => data
    else
      render :json => { error: "user did not save"}
    end
  end

  def new
  # using to fetch user id if client has user_id in cookie
    if current_session?
      p "there is a session"
      current_user
      p @user
      p response = { id: @user.id }
      render :json => response
    else
      p "no current session"
      render :json => { error: "couldn't find user based on client cookie" }
    end
  end

  def login
    p "session"
    p session[:user_id]
    @user = User.find_by(email: params[:email])
    p params
    p "attempting login with user" * 5
    p @user.inspect
    set_session
    p session[:user_id]
    if @user && @user.password == params[:password]
      render :json => { id: @user.id }
    else
      render :json => {error: "user not found, login failed"}
    end
  end

  def logout
    p "leaving session" << session[:user_id]
    logout_user if current_session?
    p "logged out"
    p session
  end

  def send_verification_code
    set_user
    set_session
    p "first, the params"
    p params
    current_user # rewrite this
    p "session is: #{session[:user_id]} and user is #{current_user.inspect}"
    set_user_phone

    if /\+1\d{10}/.match(params[:number])
      set_user_verification_code
      build_and_send_code
    elsif /\d{10}/.match(params[:number])
      set_user_verification_code
      build_and_send_code
    else
      render :json => {
        error: "Your phone number format is invalid.
        Please use this format: +15558675309."}
      end
    end

    def verify_code
      p "in verify_code route"
      p params
      user_entered_code = params[:number]
      p set_user
      if user_entered_code == @user.verification_code
        set_phone_verified
        render :json => { phone_verified: true, welcome: "Welcome to Hummingbird!"}
      else
        render :json => {error: "Your verification code is incorrect. Please request another."}
      end
    end

    private

    def generate_verification_code
      totp = ROTP::TOTP.new("base32secret3232")
      totp.now.to_s
    end

    def build_and_send_code
      setup_sms
      send_sms(@user.phone_number, "Your verification code is: " + @user.verification_code)
    end

  end
