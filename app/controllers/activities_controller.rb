class ActivitiesController < ApplicationController

  def mes_activites
    # @activities = Activity.all.order(starting_date: "asc") # on n'affiche plus toutes les cartes
    # si l'utilisateur a  sélectionné une date spécifique pour afficher les activités
    if params[:activity_date]
      @activities = Activity.where("CAST(starting_date AS DATE) = ?", params[:activity_date]).order(starting_date: "asc")
      # @activities = Activity.all.select do |activity|
      #   activity.starting_date.to_date == params[:activity_date].to_date
      #   debugger
      # end
      # (“CAST(created_at AS DATE) = ?”, Date.yesterday)
    else
      # par défaut l'utilisateur reçoit les activités de la date du jour
      @activities = Activity.where("starting_date < ?", Date.tomorrow).order(starting_date: "asc")
    end

    @current_activity = @activities.find_by(activity_status: "inprogress")
    @next_activity = @activities.find_by(activity_status: "planned")
    @markers = @activities.geocoded.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { activity: activity }),
        marker_html: render_to_string(partial: "marker", locals: { activity: activity })
      }
    end
    @mapbox_api_key = ENV['MAPBOX_API_KEY']
  end

  def index
    if params[:schedule_child_id]
      @activities = Activity.where(child_id: params[:schedule_child_id]).order(:starting_date)
      render json: { activities: @activities }
    else
      render json: { error: "Aucun enfant sélectionné." }, status: :unprocessable_entity
    end
  end

  def show
    @activity = Activity.find(params[:id])
    if @activity.activity_type == "journey"
      @next_activity = Activity.where("starting_date > ?", @activity.starting_date)
                              .order(starting_date: :asc)
                              .first
      @mapbox_api_key = ENV['MAPBOX_API_KEY']
    end
  end

  def start
    # Rails.logger.info "Params reçus : #{params.inspect}" # pour debugg
    @activity = Activity.find(params[:activity_id])

    if @activity.update(activity_status: "inprogress")
      ActionCable.server.broadcast "notifications_channel", {
        message: "L'activité '#{@activity.name}' a commencé."
      }
      render json: { update_message: "L'activité est démarrée", status: true }
    else
      render json: { update_message: "Erreur, l'activité n'est pas démarrée", status: false }, status: :unprocessable_entity
    end
  end

  def finish
    @activity = Activity.find(params[:activity_id])

    if @activity.update(activity_status: "finished")
      ActionCable.server.broadcast "notifications_channel", {
        message: "L'activité '#{@activity.name}' est terminée."
      }
      render json: { update_message: "L'activité est terminée", status: true }
    else
      render json: { update_message: "Erreur, l'activité n'est pas terminée", status: false }, status: :unprocessable_entity
    end
  end

  def create
    activity_params = params.require(:activity).permit(:child_id, :name, :starting_date, :ending_date, :photo)

    # Gestion de l'upload de la photo via Cloudinary
    if activity_params[:photo].present?
      uploaded_photo = Cloudinary::Uploader.upload(activity_params[:photo].path)
      cloudinary_id = uploaded_photo["public_id"]
    end

    # Logique pour sauvegarder l'activité
    @activity = Activity.new(
      child_id: activity_params[:child_id],
      name: activity_params[:name],
      starting_date: activity_params[:starting_date],
      ending_date: activity_params[:ending_date],
      photo: cloudinary_id
    )

    if @activity.save
      redirect_to relative_dashboard_path, notice: "Activité créée avec succès !"
    else
      redirect_to relative_dashboard_path, alert: "Erreur lors de la création de l'activité."
    end
  end

end
