module SessionsHelper
  def sign_in(user)
    #generate a new token
    remember_token= User.new_remember_token
    #save the unencrypted token to browser cookies
    cookies.permanent[:remember_token]=remember_token
    #save the encrypted token to database
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    #tell application the user is signed in and who he is
    self.current_user= user
  end

  def current_user=(user)
    @current_user= user
  end

  def current_user
    encrypted_token=User.encrypt(cookies[:remember_token])
    @current_user ||=User.find_by(remember_token:encrypted_token)
  end

  def signed_in?
    !current_user.nil?
  end


  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end


  def current_user?(user)
    user == current_user
  end


  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end


  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end


  def store_location
    session[:return_to] = request.url if request.get?
  end

  def store_current_location
    session[:return_to] = request.referrer
  end
end
