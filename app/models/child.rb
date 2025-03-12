class Child < ApplicationRecord
  has_one :user, as: :userable
  has_many :activities
  has_many :relatives, class_name: "Relative", foreign_key: "relative_id"
  has_many :educators, class_name: "Educator", foreign_key: "educator_id"
end
