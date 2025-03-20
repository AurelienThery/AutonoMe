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
# Pour parser les fichiers avec les utilisateurs et toutes les activités
require "csv"

# Nettoyage de la base (efface les users de la DB avant d'en créer de nouveaux)
ChecklistItem.destroy_all
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
puts "#{User.last.first_name} a été créé"

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
  last_name:"Carpaccio",
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

filetoday = Rails.root.join('db', 'data', 'today_seeds.csv')
filecollege = Rails.root.join('db', 'data', 'college_seeds.csv')

# Initialisation de la date du jour (démarrant à 00:00:00)
TODAY = Date.today.to_time + 3600 # on considère qu'aujourd'hui c'est vendredi :-)
MONDAY = TODAY + 86400*2    # donc dans deux jours c'est lundi :-)
# puts TODAY
# puts filetoday

# Creation des activité spécifiques à la journée demo day
CSV.foreach(filetoday, headers: :first_row, col_sep: ';') do |row|
  today_activity = Activity.new(
    name: row['name'],
    activity_type: row['activity_type'],
    description: row['description'],
    address: row['address'],
    starting_date: TODAY + row['starting_time'].to_i,
    ending_date: TODAY + row['starting_time'].to_i + row['duration'].to_i,
    child_id: Child.last.id,
    educator_id: Educator.all.sample.id,
    relative_id: Relative.all.sample.id
  )
  file = URI.parse(Cloudinary::Utils.cloudinary_url(row['picture'])).open
  today_activity.photo.attach(io: file, filename: "#{today_activity.name}.jpeg", content_type:"image/jpeg")
  today_activity.save
  puts "#{today_activity.name} créé"

  # Création des checklist items associés à l'activité
  case today_activity[:name]
  when "Demo Day: lancement"
    ChecklistItem.create!(activity: today_activity, content: "Prends ton casque anti-bruit")
    puts "Checklist pour #{today_activity.name} créée"
  # when "Présentation projet"
  #   ChecklistItem.create!(activity: today_activity, content: "Prends ton casque anti-bruit")
  #   puts "Checklist pour #{today_activity.name} créée"
  else
    puts "Activité ignorée : #{today_activity[:name]}"
  end
end

# Creation des activités d'une semaine au collège
day = MONDAY
1.times do
  CSV.foreach(filecollege, headers: :first_row, col_sep: ';') do |row|
    college_activity = Activity.new(
      name: row['name'],
      activity_type: row['activity_type'],
      description: row['description'],
      address: row['address'],
      starting_date: day + row['starting_time'].to_i,
      ending_date: day + row['starting_time'].to_i + row['duration'].to_i,
      child_id: Child.last.id,
      educator_id: Educator.all.sample.id,
      relative_id: Relative.all.sample.id
    )
    file = URI.parse(Cloudinary::Utils.cloudinary_url(row['picture'])).open
    college_activity.photo.attach(io: file, filename: "#{college_activity.name}.jpeg", content_type: "image/jpeg")
    college_activity.save
    puts "#{college_activity.name} créé"

    case college_activity[:name]
    when "Mathematiques"
      ChecklistItem.create!(activity: college_activity, content: "Prends le livre de #{college_activity.name}", completed: true )
      puts "Checklist pour #{college_activity.name} créée"
    when "Francais"
      ChecklistItem.create!(activity: college_activity, content: "Prends le livre de #{college_activity.name}")
      puts "Checklist pour #{college_activity.name} créée"
    when "Anglais"
      ChecklistItem.create!(activity: college_activity, content: "Prends le livre d'#{college_activity.name}")
      puts "Checklist pour #{college_activity.name} créée"
    else
      puts "Activité ignorée : #{college_activity[:name]}"
    end
  end
  day += 1
end
