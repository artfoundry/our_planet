require 'active_record'

class Member < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships

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

end
