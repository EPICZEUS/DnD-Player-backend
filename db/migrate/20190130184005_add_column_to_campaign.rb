class AddColumnToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :public, :boolean
  end
end
