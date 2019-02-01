class CreateApiV1Characters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.references :user, foreign_key: true
      t.references :campaign, foreign_key: true
      t.string :name
      t.string :race
      t.string :class
      t.integer :level
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :cha
      t.string :speed
      t.integer :hp
      t.string :alignment
      t.integer :armor_class

      t.timestamps
    end
  end
end
