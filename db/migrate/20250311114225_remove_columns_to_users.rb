class RemoveColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :typetable_id
    remove_column :users, :typetable_type
  end
end
