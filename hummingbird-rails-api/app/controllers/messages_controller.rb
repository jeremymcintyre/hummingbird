class MessagesController < ActionController::API

  def send_messages
    # logic with shitty ass code to see if they are to be sent out
    # batch of messages that makes me api...get it
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
