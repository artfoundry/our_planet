require 'active_record'

class Member < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
end