class Educator < ApplicationRecord
  has_many :users, as: :userable
  has_many :activities
end
