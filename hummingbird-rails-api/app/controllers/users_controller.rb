# require 'twilio-ruby'

class UsersController < ActionController::API

  def send_verification_code
    setup_sms
    send_sms(params[:number],
      "Your verification code is: " + generate_verification_code)
  end

  def missing_phone
    # user = User.find_by(dat google info)
    # user.phone_number.nil?
    # redirect user if this returns true
    # otherwise, return something to client
    # probably redirect them to send_verifcation_code client route
  end

  def verify_code
    # code = params[:number]
    # user = User.find_by(google stuff)
    # if code == user.verification_code
    # this route will be hit when the user sends the verification
    # code they get after requesting it in users#send_verification_code
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
