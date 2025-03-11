class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.date :starting_date
      t.date :ending_date
      t.boolean :like
      t.text :description
      t.string :activity_pic_id
      t.references :child, null: false, foreign_key: true
      t.references :educator, null: false, foreign_key: true
      t.references :relative, null: false, foreign_key: true

      t.timestamps
    end
  end
end
