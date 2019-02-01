class AddNewColumnToEncounter < ActiveRecord::Migration[5.2]
  def change
    add_column :encounters, :name, :string
  end
end
