class Post < ActiveRecord::Base
  validates :member_id, :title, :text, :presence => true
  belongs_to :member
end
