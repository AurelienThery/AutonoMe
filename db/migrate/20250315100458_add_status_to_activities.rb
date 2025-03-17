class AddStatusToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :activity_status, :string, default: 'planned'
  end
end
