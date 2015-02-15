# require 'twilio-ruby'

class UsersController < ActionController::API

  def send_verification_code
      user = User.find_by(id: params[:id]) # will grab id from front end client
      user.phone_number = params[:number] # saves their phone number

    if /\+1\d{10}/.match(params[:number])
      p "+1 followed by 10 digits"
      p number
      code = generate_verification_code
      user.verification_code = code # stores generated code in DB
      setup_sms
      send_sms(params[:number],
        "Your verification code is: " + code)
    elsif /\d{10}/.match(params[:number])
      p params[:number]
      number = "+1" + params[:number]
      code = generate_verification_code
      user.verification_code = code # stores generated code in DB
      p "10 digit number with +1 appended"
      p number
      setup_sms
      send_sms(params[:number],
        "Your verification code is: " + code)
    else
      render :json => {
        error: "Your phone number format is invalid.
        Please use this format: +15558675309."}
    end
  end

  def verify_code
    p "8"*80
    p params
    # this route will be hit when the user sends the verification
    # code they get after requesting it in users#send_verification_code
    user_entered_code = params[:number] # this is from the client-side form submission
    p user_entered_code
    user = User.find_by(id: params[:id]) # will grab id from front end client
    p username
    username = User.name
    if user_entered_code == user.verification_code # compares client and DB codes
    # if code == user.code_verified, send client welcome message to render
      user.phone_verified = true
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
