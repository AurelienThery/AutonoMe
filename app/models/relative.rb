class Relative < ApplicationRecord
  has_one :user, as: :userable
  has_many :activities
end
