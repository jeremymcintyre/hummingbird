module MessagesHelper

  private

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
