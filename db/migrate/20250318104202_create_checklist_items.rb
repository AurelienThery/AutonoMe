class CreateChecklistItems < ActiveRecord::Migration[7.1]
  def change
    create_table :checklist_items do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
