class Activity < ApplicationRecord
  belongs_to :child
  belongs_to :educator
  belongs_to :relative
end
