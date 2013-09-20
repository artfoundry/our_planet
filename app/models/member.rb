require 'active_record'
require 'bcrypt'

class Member < ActiveRecord::Base
  include BCrypt

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :posts

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end  

  def in_friendship_table?(potential_friend)
    a = Friendship.where('member_id =?', self.id)
    b = Friendship.where('friend_id =?', self.id)
    a.each do |friendship| 
      return true if friendship.friend_id == potential_friend.id
    end

    b.each do |friendship|
      return true if friendship.member_id == potential_friend.id
    end
    false
  end  

  def is_confirmed_friend?(potential_friend)
    a = Friendship.where('member_id =?', self.id)
    b = Friendship.where('friend_id =?', self.id)
    a.each do |friendship| 
      return true if (friendship.friend_id == potential_friend.id) && (friendship.accepted? == true)
    end

    b.each do |friendship|
      return true if (friendship.member_id == potential_friend.id) && (friendship.accepted? == true)
    end
    false
  end  

  def full_name
    "#{first_name} #{last_name}"
  end
end
