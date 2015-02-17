class MessagesController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def create
    user = User.find_by(params[:id])
    from = user.phone_number
    to = params[:number]
    sms_body = params[:body]
    message = user.messages.new(to: to, from: from, body: sms_body, send_at_datetime: params[:send_at_datetime])
    message.save
  end

  def index
    messages = User.find_by(params[:id]).messages.where(sent: to_boolean(params[:sent]))
    render json: {messages: messages}
  end

private
  def to_boolean(string)
    string == 'true'
  end
end
