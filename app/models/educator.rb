class Educator < ApplicationRecord
  has_one :user, as: :userable
  has_many :activities
end
