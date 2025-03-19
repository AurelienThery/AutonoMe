class UsersController < ApplicationController
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
