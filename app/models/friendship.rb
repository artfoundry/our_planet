require 'active_record'

class Friendship < ActiveRecord::Base
  belongs_to :member
  belongs_to :friend, :class_name => "Member"

end