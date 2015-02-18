class MessageQueueHandler
  include MessagesHelper
  include UsersHelper
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

    def send_messages
      batch = Message.where("send_at_datetime <= ? and sent = ?", Time.now, false)

      batch.each do |message|
        send_message(message.to, message.body + "\n Sent to you from: #{message.from}")
        message.update_attributes(sent: true)
      end
    end

end
