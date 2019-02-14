class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.integer :x
      t.integer :y
      t.references :encounter, foreign_key: true
      t.references :playable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
