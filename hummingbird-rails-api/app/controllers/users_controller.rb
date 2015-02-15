# require 'twilio-ruby'

class UsersController < ActionController::API

  def send_verification_code
    user = User.find_by(id: params[:id]) # will grab id from front end client
    user.phone_number = params[:number] # saves their phone number
    code = generate_verification_code
    user.verification_code = code # stores generated code in DB
    setup_sms
    send_sms(params[:number],
      "Your verification code is: " + code)
  end

  def verify_code
    # this route will be hit when the user sends the verification
    # code they get after requesting it in users#send_verification_code
    user_entered_code = params[:number] # this is from the client-side form submission
    user = User.find_by(id: params[:id]) # will grab id from front end client
    username = User.name
    if user_entered_code == user.verification_code # compares client and DB codes
    # if code == user.code_verified, send client welcome message to render
      render :json => { welcome: "Hey Username #{username}!"}
    else
    # else, send client error message to render
      render :json => {error: "Your verification code is incorrect. Please request another."}
    end
  end

  private

    def generate_verification_code
      totp = ROTP::TOTP.new("base32secret3232")
      totp.now.to_s
    end

    def setup_sms
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end

    def send_sms(to, body)
      @client.messages.create(
        from: ENV['TWILIO_NUMBER'],
        to: to,
        body: body)
    end

end
