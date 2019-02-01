class CreateCreaturesEncounters < ActiveRecord::Migration[5.2]
  def change
    create_table :creatures_encounters do |t|
      t.references :encounter, foreign_key: true
      t.references :creature, foreign_key: true
    end
  end
end
