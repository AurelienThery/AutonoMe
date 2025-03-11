class Relative < ApplicationRecord
  has_many :users, as: :userable
end
