class MessagesController < ActionController::API

  def create
    # receive form data with message body & date/time to deliver
    # pull user phone number from DB & append to sms body
    p "*"*50
    p params
    # user = User.find_by()
    to = params[:number]
    sms_body = params[:body] + "\n Sent to you from: #{to}"
    send_message(to, sms_body)
  end

  def send_messages
    # logic with code to see if they are ready to be sent out
    # batch of messages
    @batch.each do |message|
      # need to include User.phone_number in body
      send_message(message.to, message.body)
    end
  end

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
