class CreateCharactersEncounters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters_encounters do |t|
      t.references :character, foreign_key: true
      t.references :encounter, foreign_key: true
    end
  end
end
