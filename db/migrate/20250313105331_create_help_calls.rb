class CreateHelpCalls < ActiveRecord::Migration[7.1]
  def change
    create_table :help_calls do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :need
      t.string :help_message
      t.boolean :status

      t.timestamps
    end
  end
end
