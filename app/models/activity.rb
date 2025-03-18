class Activity < ApplicationRecord
  belongs_to :child
  belongs_to :educator
  belongs_to :relative
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :checklist_items


   # enumerable pour stocker les types d'activités
  # /!\ stocké en integer dans bdd donc ds table activity: t.integer "activity_type"
  enum activity_type: %i[journey activity breaktime]

  # on indique en validation du activity_type la liste des clés de user_typeS
  validates :activity_type, inclusion: { in: Activity.activity_types.keys }
  # ajouter presence: true quand les seeds seront créées avec cette column
end
