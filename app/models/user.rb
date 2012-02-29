class User < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable,
      :rememberable, :registerable, :trackable, :timeoutable,
      :token_authenticatable, :omniauthable

  attr_accessible :login, :login_type, :email, :name, :password, :password_confirmation, :send_notifications
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if not (user = User.where(:email => data.email).first)
      user = User.create!(
          :email => data.email,
          :login => data.email,
          :login_type => 'facebook',
          :name => "#{data.first_name} #{data.last_name}",
          :password => Devise.friendly_token[0,20],
          :image => access_token.info.image
      )
      CommentMailer.welcome(user).deliver
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data.email
      end
    end
  end
  
  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if not (user = User.where(:email => data.email).first)
      user=User.create!(
          :email => data.email,
          :login => data.email,
          :login_type => 'google',
          :password => Devise.friendly_token[0,20]
      )
      CommentMailer.welcome(user).deliver
    end
    user
  end
  
  def self.find_for_twitter(access_token, signed_in_resource=nil)
    data = access_token.info
    nickname = "@#{data.nickname}"
    if not (user = User.where(:login => nickname).first)
      user = User.create!(
        :login => nickname,
        :login_type => 'twitter',
        :password => Devise.friendly_token[0,20]
      )
      #CommentMailer.welcome(user).deliver
    end
    user
  end

  def screen_name
    if self.name
      self.name
    elsif self.login.starts_with?('@')
      self.login
    else
      'un usuario'
    end
  end

  def contact_name
    if self.name and not self.name.blank?
      self.name
    elsif self.login
      self.login
    else
      self.email
    end
  end
end
