class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :typetable_id, :integer
    add_column :users, :typetable_type, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :photo_id, :string
    add_column :users, :setting_id, :integer
  end
end
