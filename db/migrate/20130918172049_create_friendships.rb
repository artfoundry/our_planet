class CreateFriendships < ActiveRecord::Migration
  def up
    create_table :friendships do |t|
      t.belongs_to :member
      t.belongs_to :friend
      t.boolean    :accepted?
      t.timestamps
    end
  end

  def down
    drop_table :friendships
  end
end
