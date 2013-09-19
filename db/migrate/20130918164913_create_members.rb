class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email  
      t.string :password
      t.timestamps
    end
  end

  def down
    drop_table :members
  end
end
