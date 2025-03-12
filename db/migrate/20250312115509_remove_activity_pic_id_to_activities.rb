class RemoveActivityPicIdToActivities < ActiveRecord::Migration[7.1]
  def change
    remove_column :activities, :activity_pic_id, :string
  end
end
