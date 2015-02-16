class MessagesController < ActionController::API
  include MessageHelper

  def create
    user = User.find_by(params[:id])
    from = user.phone_number
    to = params[:number]
    sms_body = params[:body] + "\n Sent to you from: #{from}"
    message = user.messages.new(to: to, from: from, body: sms_body, send_at_datetime: params[:send_at_datetime])
    message.save
  end

end
