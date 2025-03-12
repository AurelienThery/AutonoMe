class ChangeDatetypeToActivities < ActiveRecord::Migration[7.1]
  def change
    change_table :activities do |t|
      t.change :starting_date, :datetime
      t.change :ending_date, :datetime
    end
  end
end
