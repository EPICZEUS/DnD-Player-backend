class CreateApiV1Messages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :channel, polymorphic: true, index: true
      t.references :user, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
