require_relative '../config'


class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :firstname
      t.string   :lastname
      t.string   :email
      t.string   :password
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
