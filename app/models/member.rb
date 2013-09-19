require 'active_record'

class Member < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :posts

  def is_friend?(potential_friend)
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

  def full_name
    "#{first_name} #{last_name}"
  end
end
