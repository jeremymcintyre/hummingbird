class UsersController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def index

    render json: "asdgaf"
  end

  def show
    user = User.find(1)
    if user.nil?
      render json: "whatever?"
    else
      render json: "success"
    end
  end

  def create
    @user = User.new(
      email: params[:email],
      password_hash: params[:password_hash],
      phone_number: params[:phone_number])
    @user.password = params[:password]

    if @user.save
      render json: { success: "user saved"}
    else
      render json: { error: "user did not save"}
    end

  end

  def send_verification_code
    current_user
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
