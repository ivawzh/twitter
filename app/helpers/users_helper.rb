module UsersHelper
  #returns the Gravatar (http://gravatar.com/) for the given user
  def gravatar_for(user, option={ size:55 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = option[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end


  def followed_users_of(user)
    @followed_users||=user.followed_users
  end








end
