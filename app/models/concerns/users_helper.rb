module UsersHelper

  private

  def current_user
    @user = User.find_by(id: session[:user_id]) unless session[:used_id].nil?
  end

  def set_user_phone
    @user.update_attributes(phone_number: params[:number])
  end

  def set_user_verification_code
    @user.update_attributes(verification_code: generate_verification_code)
  end

  def set_phone_verified
    @user.update_attributes(phone_verified: true)
  end
end
