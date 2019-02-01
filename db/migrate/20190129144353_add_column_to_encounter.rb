class AddColumnToEncounter < ActiveRecord::Migration[5.2]
  def change
    add_column :encounters, :background_url, :string
  end
end
