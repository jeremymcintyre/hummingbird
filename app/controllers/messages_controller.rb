class MessagesController < ActionController::API
  include UsersHelper

  def create
    user = User.find_by(id: params[:user_id].to_i)
    from = user.phone_number
    to = params[:number]
    sms_body = params[:body]
    message = user.messages.new(to: to, from: from, body: sms_body, send_at_datetime: params[:send_at_datetime])
    message.save
  end

  def destroy
    Message.find_by(id: params[:id]).destroy
  end

  # if params sent="true", show sent messages, otherwise show delivered
  def index
    user = User.find_by(id: params[:user_id].to_i)
    sent_status = to_boolean(params[:sent])

    if params[:sent]
      messages = user.messages.where(sent: sent_status).order('send_at_datetime ASC')
      render json: {messages: messages}
    else
      messages = user.messages
      render json: {messages: messages}
    end
  end

  private
  def to_boolean(string)
    string == 'true'
  end
end
