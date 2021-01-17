class DevicesController < ApplicationController

  before_action :authenticate_user!, only: [:destroy]
  protect_from_forgery

  before_action :set_device, only: [:destroy]

  def destroy
    if @device.destroy
      redirect_back fallback_location: root_path, notice: "#{@device.name} was deleted!"
    else
      redirect_back fallback_location: root_path, notice: "#{@device.name} not deleted!"
    end
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

end
