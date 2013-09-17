require_relative '../../db/config'

class Member < ActiveRecord::Base
  has_many :posts
  has_many :friends class_name: "Member" through :friendships
end
