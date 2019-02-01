class CreateApiV1Encounters < ActiveRecord::Migration[5.2]
  def change
    create_table :encounters do |t|
      t.references :campaign, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
