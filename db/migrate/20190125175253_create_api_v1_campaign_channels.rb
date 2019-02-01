class CreateApiV1CampaignChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_channels do |t|
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
