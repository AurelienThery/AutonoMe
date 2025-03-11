class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
    @first_name = @user.first_name
  end
end

private

def set_user
  @user = User.find(params[:id])
end
