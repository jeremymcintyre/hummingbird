class MessagesController < ActionController::API

  def create
    # receive form data with message body & date/time to deliver
    # pull user phone number from DB & append to sms body
    p "*"*50
    p params
    user = User.find_by(params[:id])
    from = user.phone_number
    to = params[:number]
    sms_body = params[:body] + "\n Sent to you from: #{from}"
    # Build message
    message = Message.new(to: to, from: from, body: sms_body, send_at_datetime: params[:send_at_datetime])
    # save message to DB
    message.save
    # how do we handle validation errors for this???
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
