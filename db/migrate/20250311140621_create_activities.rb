class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.date :starting_date
      t.date :ending_date
      t.integer :educator_id
      t.integer :relative_id
      t.integer :child_id
      t.boolean :like
      t.string :description
      t.string :activity_pic_id

      t.timestamps
    end
  end
end
