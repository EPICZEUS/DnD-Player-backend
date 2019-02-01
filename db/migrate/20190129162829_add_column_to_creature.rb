class AddColumnToCreature < ActiveRecord::Migration[5.2]
  def change
    add_column :creatures, :size, :string
  end
end
