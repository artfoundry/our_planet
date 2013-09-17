require_relative '../config'

class CreateFriendships < ActiveRecord::Migration
  def change
    create_table(:friendships) do |t|
      t.string :name
      t.belongs_to :member
      t.belongs_to :friend

      t.timestamps
    end
  end
end
