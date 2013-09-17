require_relative '../../db/config'

class Post < ActiveRecord::Base
  belongs_to :members
end
