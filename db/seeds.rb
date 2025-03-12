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
puts "Emilie (educatrice) a été créé"

puts "Création des activités d'une journée courte"
LIST_ACTIVITIES = %w[Trajet_aller Mathematiques Français Histoire Trajet_retour]
LIST_DESCRIPTIONS = %w[matin cours1 cours2 cours3 soir]
LIST_PICTURES = %w[college_jiemug cours_maths_jtebnf cours_francais_fdeyk0 cours_histoire_tlsvxi maison_j3nvou]
DAY_STARTS_AT = DateTime.tomorrow.to_time + 8 * 3600

LIST_ACTIVITIES.each_with_index do |activite, index|
  activite = Activity.new(
    name: LIST_ACTIVITIES[index],
    starting_date: DAY_STARTS_AT + (index * 3600),
    ending_date: DAY_STARTS_AT + 3600,
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
