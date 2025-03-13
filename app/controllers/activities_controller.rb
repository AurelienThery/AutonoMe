class ActivitiesController < ApplicationController

  def mes_activites
    @activities = Activity.all.order(starting_date: "asc")
  end

  def show
    @activity = Activity.find(params[:id])
  end
end
