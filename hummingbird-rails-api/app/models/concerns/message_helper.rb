module MessageHelper
  private

  def current_user
    user = User.find_by(id: params[:id])
  end
  # this is DRY-er but would require additional DB calls
  # in the case of something like current_user.name or whatever
  # I guess you could do user = current_user to get around that


  # These steps are in like 3 places and should probably be consolidated here
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
