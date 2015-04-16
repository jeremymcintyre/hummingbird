module UsersHelper

  private

  def current_user
    unless @user
      p "in current user helper"
      @user = User.find_by(id: params[:user_id])
      session[:user_id] = @user.id
      p "results of current helper:  #{@user.email} and #{session[:user_id]}"
      @user
    else
      @user
    end
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
