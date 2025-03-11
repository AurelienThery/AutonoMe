class Child < ApplicationRecord
  has_many :users, as: :userable
end
