class Schedule < ApplicationRecord
  belongs_to :child

  validates :activity_name, :starting_date, :ending_date, presence: true
end
