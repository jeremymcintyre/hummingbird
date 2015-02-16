class MessageQueueHandler
  include SuckerPunch::Job
  workers 4

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      send_messages
    end
    later(45)
  end

  def later(sec)
    after(sec) { perform }
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

    def send_messages
      batch = Message.where("send_at_datetime <= ? and sent = ?", Time.now, false) # sends messages that have send_date_time < Time.now
      p batch
      batch.each do |message|
        p message.to
        p message.body
        send_message(message.to, message.body)
      end
    end
end
