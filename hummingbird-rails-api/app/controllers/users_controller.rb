# require 'twilio-ruby'

class UsersController < ActionController::API
  def send_verification_code
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: params[:number],
      body: 'Random number!'
    )
    puts "it should have worked."
  end

end
