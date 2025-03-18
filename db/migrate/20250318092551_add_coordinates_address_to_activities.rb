class AddCoordinatesAddressToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :latitude, :float
    add_column :activities, :longitude, :float
    add_column :activities, :address, :string
  end
end
