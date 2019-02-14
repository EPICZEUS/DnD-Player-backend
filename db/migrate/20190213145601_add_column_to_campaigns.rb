class AddColumnToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :selected_encounter, :integer
  end
end
