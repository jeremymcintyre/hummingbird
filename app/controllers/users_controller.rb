class UsersController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def index
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    render json: "APIs don't have index pages"
  end

  def show
    # Need to revise this. These routes should not be publicly accessible and/or should return a proper response or warning to anyone accessing them.
    user = User.find(1)
    if user.nil?
      render json: "No users here."
    else
      render json: "Found the user."
    end
  end

  def register
    p params
    # if user exists, go to new message page
    # else, make new user, set BCrypt password
    # and return / leave them on login page
    @user = User.new(
      email: params[:email],
      password_hash: params[:password_hash],
      phone_number: params[:phone_number])
      # should this be params[:password_hash]
      # BCrypt is confusing me
    @user.password = params[:password]

    if @user.save
      render json: { success: "user register and saved to database"}
    else
      render json: { error: "user did not save"}
    end
  end

  def login
    # if user exists in DB, return JSON
    # telling client to send user to new_message
    # otherwise, render form error message?
  end

  def send_verification_code
    current_user # This doesn't work right
    set_user_phone

    p params
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
