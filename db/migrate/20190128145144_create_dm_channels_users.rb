class CreateDmChannelsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :dm_channels_users do |t|
      t.references :user, foreign_key: true
      t.references :dm_channel, foreign_key: true
    end
  end
end
