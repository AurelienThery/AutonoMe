class Activity < ApplicationRecord
  belongs_to :children
  belongs_to :educators
  belongs_to :relatives
end
