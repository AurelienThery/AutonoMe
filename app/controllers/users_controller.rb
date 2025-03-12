class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
    @first_name = @user.first_name
  end
end

private

def set_user
  @user = current_user
  @activities = Activity.where(child_id: @user.userable.id)
  # @educators = Educator.where(id: @activities.educator_id)
end
