module UsersHelper

  private

  def current_user
    @user = User.find_by(id: session[:id])
  end

  def set_user_phone
    current_user.update_attributes(phone_number: params[:number])
  end

  def set_user_verification_code
    current_user.update_attributes(verification_code: generate_verification_code)
  end

  def set_phone_verified
    current_user.update_attributes(phone_verified: true)
  end
end
