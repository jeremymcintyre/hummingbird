class UsersController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def index
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    render :json "APIs don't have index pages"
  end

  def show
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    user = User.find(1)
    if user.nil?
      render :json "No users here."
    else
      render :json "Found the user."
    end
  end

  def create
    p params
    # if user exists, go to new message page
    # else, make new user, set BCrypt password
    # and return / leave them on login page
    @user = User.find_or_initialize_by(email: params[:email])
    @user.update_attributes(password_hash: params[:password])
    @user.password = params[:password]

    if @user.save
      session[:user_id] = @user.id
      p "here's the session" * 5
      p session
      p "here's the new user" * 5
      p @user
      render :json { id: @user.id }
    else
      render :json { error: "user did not save"}
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    p params
    p "attempting login with user" * 5
    p @user
    p session[:user_id]
    if current_user && @user.password == params[:password]
      render :json { success: "user #{@user.id} exists, and is logged in with session #{session[:user_id]}"}
    else
      render :json { error: "user not found, login failed"}
    end
    # if user exists in DB, return JSON
    # telling client to send user to new_message
    # otherwise, render form error message?
  end

  def logout
    if current_user
      session[:user_id] = nil
      render :json { success: "successful logout"}
    else
      render :json { error: "logout failed"}
    end
  end

  def send_verification_code
    current_user # This doesn't work right
    p current_user
    p params
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
      user_entered_code = params[:number]
      current_user
      username = @user.name
      if user_entered_code == @user.verification_code
        set_phone_verified
        render :json => { phone_verified: true, welcome: "Hey #{username}!"}
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
