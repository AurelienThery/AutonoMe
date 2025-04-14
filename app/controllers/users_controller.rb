class UsersController < ApplicationController
  require 'roo'
  require 'csv'
  before_action :set_user, only: [:show]
  before_action :set_simon, only: [:show]


  def index
  end

  def show
    @first_name = @user.first_name
    @activities = Activity.where(child_id: @user.userable.id).order(starting_date: "asc")
    @current_activity = @activities.first
  end
end

def relative_dashboard
  # Vérifiez que l'utilisateur est un relative
  if current_user.relative?
    @activities = Activity.where(relative_id: current_user.userable_id)
  else
    redirect_to root_path, alert: "Vous n'avez pas accès à cette page."
  end
end

def import_schedule
  if params[:file].present?
    file = params[:file]
    spreadsheet = Roo::Spreadsheet.open(file.path)

    # Supposons que les données sont dans la première feuille
    header = spreadsheet.row(1) # La première ligne contient les en-têtes
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # Exemple : Créer une activité pour un enfant à partir des données
      Activity.create!(
        name: row["Nom de l'activité"],
        starting_date: row["Date de début"],
        ending_date: row["Date de fin"],
        relative_id: current_user.userable_id,
        child_id: row["ID de l'enfant"] # Assurez-vous que cette colonne existe dans le fichier Excel
      )
    end

    redirect_to relative_dashboard_path, notice: "Emploi du temps importé avec succès."
  else
    redirect_to relative_dashboard_path, alert: "Veuillez sélectionner un fichier."
  end
end

def export_schedule
  @activities = Activity.where(child_id: params[:child_id])

  if @activities.any?
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Nom de l'activité", "Date de début", "Date de fin"]

      @activities.each do |activity|
        csv << [activity.name, activity.starting_date.strftime("%d/%m/%Y %H:%M"), activity.ending_date.strftime("%d/%m/%Y %H:%M")]
      end
    end

    send_data csv_data, filename: "emploi_du_temps.csv"
  else
    redirect_to relative_dashboard_path, alert: "Aucune activité trouvée pour cet enfant."
  end
end

private

def set_user
  @user = current_user
end


def set_simon
  current_user_id = User.find_by(first_name: "Simon")
  if current_user.id ==current_user_id
    @user = current_user
  end
end
