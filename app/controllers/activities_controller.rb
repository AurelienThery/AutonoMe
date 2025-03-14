class ActivitiesController < ApplicationController

  def mes_activites
    @activities = Activity.all.order(starting_date: "asc")
    @active_activity = @activities.first
  end

  def show
    @activity = Activity.find(params[:id])
  end
end
