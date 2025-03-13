class AddTypeToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :activity_type, :integer
  end
end
