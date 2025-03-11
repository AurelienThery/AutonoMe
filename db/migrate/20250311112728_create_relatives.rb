class CreateRelatives < ActiveRecord::Migration[7.1]
  def change
    create_table :relatives do |t|

      t.timestamps
    end
  end
end
