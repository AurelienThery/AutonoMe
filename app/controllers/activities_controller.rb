class ActivitiesController < ApplicationController

  def mes_activites
    @activities = Activity.all.order(starting_date: "asc")
    @current_activity = @activities.find_by(activity_status: "inprogress")
    @next_activity = @activities.find_by(activity_status: "planned")
    @markers = @activities.geocoded.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude
      }
    end
  end

  def show
    @activity = Activity.find(params[:id])
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
