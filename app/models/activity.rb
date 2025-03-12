class Activity < ApplicationRecord
  belongs_to :child
  belongs_to :educator
  belongs_to :relative
  has_one_attached :photo
end
