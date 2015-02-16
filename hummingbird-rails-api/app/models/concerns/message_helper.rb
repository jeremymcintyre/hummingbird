module MessageHelper
  private
  # User Methods
  def current_user
    @user = User.find_by(id: params[:id])
  end

  def set_user_phone
    @user.update_attributes(phone_number: params[:number])
  end

  def set_user_verification_code
    @user.update_attributes(verification_code: generate_verification_code)
  end

  def set_phone_verified
    @user.update_attributes(phone_verified: true)
  end

  # Message Methods
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

  def send_message(to, body)
    setup_sms
    send_sms(to, body)
  end

end
