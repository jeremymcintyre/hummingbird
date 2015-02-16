# require 'twilio-ruby'

class UsersController < ActionController::API
  include MessageHelper

  def send_verification_code
    current_user
    # user = User.find_by(id: params[:id])
    set_user_phone
    # user.update_attributes(phone_number: params[:number])

    if /\+1\d{10}/.match(params[:number])
      # code = generate_verification_code
      set_user_verification_code
      # user.update_attributes(verification_code: generate_verification_code)
      build_and_send_code
      # setup_sms
      # send_sms(user.phone_number,
      # "Your verification code is: " + user.verification_code)
    elsif /\d{10}/.match(params[:number])
      # number = "+1" + params[:number]
      # code = generate_verification_code
      set_user_verification_code
      # user.update_attributes(verification_code: generate_verification_code)
      build_and_send_code
      # setup_sms
      # send_sms(user.phone_number,
      #   "Your verification code is: " + user.verification_code)
    else
      render :json => {
        error: "Your phone number format is invalid.
        Please use this format: +15558675309."}
    end
  end

  def verify_code
    user_entered_code = params[:number]
    current_user
    # user = User.find_by(id: params[:id])
    username = @user.name
    if user_entered_code == @user.verification_code
      set_phone_verified
      # user.update_attributes(phone_verified: true)
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
