class ActivitiesController < ApplicationController

  def mes_activites
    @activities = Activity.all.order(starting_date: "asc")
    @current_activity = @activities.find_by(activity_status: "inprogress")
    @next_activity = @activities.find_by(activity_status: "planned")
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def start
    @activity = Activity.find(params[:activity_id])

    if @activity.update(activity_status: "inprogress")
      render json: { update_message: "L'activité est démarrée" }
    else
      render json: { update_message: "Erreur, l'activité n'est pas démarrée" }, status: :unprocessable_entity
    end
  end
end
