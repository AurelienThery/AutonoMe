# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
# Pour pouvoir générer des dates d'activités
require 'date'

#Nettoyage de la base (efface les users de la DB avant d'en créer de nouveaux)
Activity.destroy_all
Child.destroy_all
Relative.destroy_all
Educator.destroy_all
User.destroy_all
puts "La Base de donnée à été effacée avant création de nouveaux utilisateurs"
puts "Création de 3 utilisateurs"
# création du user Simon

User.create(
  password:"123456",
  email: "simon@lewagon.org",
  first_name: "Simon",
  last_name:"Martin",
  address: "15 rue Baste, 33300 Bordeaux",
  userable: Child.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Simon_t7r62g")).open
  User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
  User.last.save
puts "Simon a été créé"

# création du user Père
User.create(
  password:"123456",
  email: "claude@lewagon.org",
  first_name: "Claude",
  last_name:"Martin",
  address: "15 rue Baste, 33300 Bordeaux",
  userable: Relative.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Claude_y1ee6a")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Claude (le père) a été créé"

# création de la mère
User.create(
  password:"123456",
  email: "marie@lewagon.org",
  first_name: "Marie",
  last_name: "Dupont",
  address: "10 rue Julien Manès, 33300 Bordeaux",
  userable: Relative.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("marie_ebhdxz")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Marie (la mère) a été créé"

# création du user Educateur
User.create(
  password:"123456",
  email: "michel@lewagon.org",
  first_name: "Michel",
  last_name:"Michel",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Michel_fbkctc")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Michel (educateur) a été créé"

# création d'un user Educateur
User.create(
  password:"123456",
  email: "jacques@lewagon.org",
  first_name: "Jacques",
  last_name:"Lefevre",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Jacques_uuy1pf")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Jacques (educateur) a été créé"

# création d'un user Educateur
User.create(
  password:"123456",
  email: "emilie@lewagon.org",
  first_name: "Emilie",
  last_name:"Champagne",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Emilie_j79wjr")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Emilie (educatrice) a été créé"

User.create(
  password:"123456",
  email: "sylvie@lewagon.org",
  first_name: "Sylvie",
  last_name:"Vatan",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Sylvie_ifn8my")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Sylvie (educatrice) a été créé"

User.create(
  password:"123456",
  email: "sihem@lewagon.org",
  first_name: "Sihem",
  last_name:"Vatan",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Sihem_g4z6ka")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Sihem (educatrice) a été créé"

User.create(
  password:"123456",
  email: "adele@lewagon.org",
  first_name: "Adele",
  last_name:"Avon",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Adele_mrvoyo")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Adele (educatrice) a été créé"

User.create(
  password:"123456",
  email: "edouard@lewagon.org",
  first_name: "Edouard",
  last_name:"Maindan",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Edouard_hbnbzz")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Edouard (educateur) a été créé"

User.create(
  password:"123456",
  email: "Jessica@lewagon.org",
  first_name: "Jessica",
  last_name:"Hartmann",
  address: "12 rue Paul Berthelot, 33300 Bordeaux",
  userable: Educator.create
)
file = URI.parse(Cloudinary::Utils.cloudinary_url("Jessica_ipr8he")).open
User.last.photo.attach(io: file, filename: "#{User.last.first_name}.jpeg", content_type:"image/jpeg")
User.last.save
puts "Jessica (educatrice) a été créé"


puts "Création des activités d'une journée courte"
LIST_ACTIVITIES = %w[Trajet_aller Mathematiques Français Histoire Trajet_retour Cantine Geographie Devoirs Gaming Gymnase Recreation Ping_Pong Tv Repas Salle_de_bain ]
LIST_DESCRIPTIONS = %w[Matin Salle_204 Salle_140 Salle_129 Soir Réfectoire Salle_224 Devoirs_du_jour Jeux_PC Sport_GymnaseA Cour_Collège Entrainement EmissionTv Repas_Famille Douche ]
LIST_PICTURES = %w[college_jiemug cours_maths_jtebnf cours_francais_fdeyk0 cours_histoire_tlsvxi maison_j3nvou cantine_eek480 classe_géographie_wdumh3 devoirs_g6c3qk gaming_xxtqo7 gymnase_kvsgdc récréation_uhj8un pingpong_mpwidx salontv_yjuodu repas_dm1z4l sdb_adclbw ]
DAY_STARTS_AT = DateTime.tomorrow.to_time + 8 * 3600

LIST_ACTIVITIES.each_with_index do |activite, index|
  activite = Activity.new(
    name: LIST_ACTIVITIES[index],
    starting_date: DAY_STARTS_AT + (index * 3600),
    ending_date: DAY_STARTS_AT + (index * 3600) + 3600,
    like: true,
    description: LIST_DESCRIPTIONS[index],
    # activity_pic_id: "",
    child_id: Child.last.id,
    educator_id: Educator.all.sample.id,
    relative_id: Relative.all.sample.id
)
  file = URI.parse(Cloudinary::Utils.cloudinary_url(LIST_PICTURES[index])).open
  activite.photo.attach(io: file, filename: "#{LIST_ACTIVITIES[index]}.jpeg", content_type:"image/jpeg")
  activite.save
  puts "#{activite.name} créé"
end
