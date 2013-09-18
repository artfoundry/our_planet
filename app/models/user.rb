require_relative '../../db/config'

class User < ActiveRecord::Base

  validates_presence_of :email

end


