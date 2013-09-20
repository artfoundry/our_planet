class RenameMembersPassword < ActiveRecord::Migration
  def up
    rename_column :members, :password, :password_hash
  end

  def down
    rename_column :members, :password_hash, :password
  end
end
