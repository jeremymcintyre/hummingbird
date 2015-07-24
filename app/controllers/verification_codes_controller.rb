class VerificationCodesController < ActionController::API
  include MessagesHelper
  # GET request
  # sends user a verification code
  def create
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

  # POST request
  # sets phone_verified flag to true if user enters correct code
    def update
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
