class RenameColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :typetable_id, :userable_id
    rename_column :users, :typetable_type, :userable_type
  end
end
