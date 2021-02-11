class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show]
  protect_from_forgery

  before_action :set_user, only: [:show]

  def show; end

  private

  def set_user
    if user_signed_in?
      @user = current_user
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :provider, :uid, :name, :description, :image)
  end

end
