class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit, :update]
  protect_from_forgery

  before_action :set_user, only: [:show, :edit, :update]

  def show; end
  def edit; end
  def update; end

  private

  def set_user
    if user_signed_in?
      @user = current_user
    end
  end

end
