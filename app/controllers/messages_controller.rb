class MessagesController < ActionController::API

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

  def scheduled
    messages = current_user.messages.where(sent: false).order('send_at_datetime ASC')
    render json: {messages: messages}
  end

  def delivered
    messages = current_user.messages.where(sent: true).order('send_at_datetime ASC')
    render json: {messages: messages}
  end

  private
  def to_boolean(string)
    string == 'true'
  end
end
