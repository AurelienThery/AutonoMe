class ActivitiesController < ApplicationController

  def mes_activites
    # @activities = Activity.all.order(starting_date: "asc") # on n'affiche plus toutes les cartes
    # si l'utilisateur a  sélectionné une date spécifique pour afficher les activités
    if params[:activity_date]
      @activities = Activity.all.select do |activity|
        activity.starting_date.to_date == params[:activity_date].to_date
        raise
      end
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
      render json: { update_message: "L'activité est démarrée", status: true }
    else
      render json: { update_message: "Erreur, l'activité n'est pas démarrée", status: false }, status: :unprocessable_entity
    end
  end

  def finish
    @activity = Activity.find(params[:activity_id])

    if @activity.update(activity_status: "finished")
      render json: { update_message: "L'activité est terminée", status: true }
    else
      render json: { update_message: "Erreur, l'activité n'est pas terminée", status: false }, status: :unprocessable_entity
    end
  end

end
