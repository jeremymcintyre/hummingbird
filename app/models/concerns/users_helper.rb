module UsersHelper

  private

  def current_session?
    !!session[:user_id] # returns boolean of statement evaluation
  end

  def current_user
    #rename to find user by session
   @user = User.find_by(id: session[:user_id])
  end

  def set_user
    #rename to find user by params
    @user = User.find(params[:user_id]) # these params come from the URL
  end

  def set_session
    session[:user_id] = @user.id if @user
  end

  def logout_user
    session[:user_id].delete
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
