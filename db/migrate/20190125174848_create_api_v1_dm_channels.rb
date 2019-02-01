class CreateApiV1DmChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :dm_channels do |t|

      t.timestamps
    end
  end
end
