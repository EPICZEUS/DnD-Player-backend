class CreateApiV1Creatures < ActiveRecord::Migration[5.2]
  def change
    create_table :creatures do |t|
      t.string :name
      t.string :type
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :cha
      t.integer :challenge_rating
      t.integer :armor_class
      t.string :speed
      t.integer :hp
      t.string :alignment

      t.timestamps
    end
  end
end
