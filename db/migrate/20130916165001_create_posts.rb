require_relative '../config'

class CreatePosts < ActiveRecord::Migration
  def change
    create_table(:posts) do |t|
      t.string :title
      t.string :text
      t.belongs_to :member

      t.timestamps
    end
  end
end
