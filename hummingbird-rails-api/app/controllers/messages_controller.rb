class MessagesController < ActionController::API
  include MessagesHelper
  include UsersHelper

  def create
    user = User.find_by(id: params[:user_id].to_i)
    from = user.phone_number
    to = params[:number]
    sms_body = params[:body]
    message = user.messages.new(to: to, from: from, body: sms_body, send_at_datetime: params[:send_at_datetime])
    message.save
  end

  def index
    # p "Params are : #{ params}"
    # p "Is in Params is : #{ params[:user_id]}"
    # p "User is #{ User.find_by(id: params[:user_id].to_i).name}"
    user = User.find_by(id: params[:user_id].to_i)
    sent_status = to_boolean(params[:sent])
    # p user.messages.pluck(:sent)

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
