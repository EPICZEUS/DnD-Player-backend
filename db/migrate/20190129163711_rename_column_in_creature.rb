class RenameColumnInCreature < ActiveRecord::Migration[5.2]
  def change
  	rename_column :creatures, :type, :creature_type
  end
end
