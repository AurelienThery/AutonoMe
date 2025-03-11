class Educator < ApplicationRecord
  has_many :users, as: :userable
end
