class ActivitiesController < ApplicationController

  def mes_activites
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end
end
