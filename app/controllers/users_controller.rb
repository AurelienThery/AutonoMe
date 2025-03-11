class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
  end
end

private

def set_task
  @user = User.find(params[:id])
end
