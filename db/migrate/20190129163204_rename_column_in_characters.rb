class RenameColumnInCharacters < ActiveRecord::Migration[5.2]
  def change
  	rename_column :characters, :class, :char_class
  end
end
