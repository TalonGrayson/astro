class DevicesController < ApplicationController

  before_action :authenticate_user!, only: [:destroy, :signal_device, :designal_device]
  protect_from_forgery

  before_action :set_device, only: [:destroy, :signal_device, :designal_device]

  def destroy
    if @device.destroy
      redirect_back fallback_location: root_path, notice: "#{@device.name} was deleted!"
    else
      redirect_back fallback_location: root_path, notice: "#{@device.name} not deleted!"
    end
  end

  def signal_device
    if user_owns_this_device?
      if ParticleService.new.publish_scan_info(signal_data)
        redirect_back fallback_location: user_path(@device.user), notice: "#{@device.name} was signalled!"
      else
        redirect_back fallback_location: user_path(@device.user), notice: "#{@device.name} could not be signalled!"
      end
    else
      redirect_to tag_path(@device), notice: 'You can\'t signal this device, it belongs to someone else.'
    end
  end

  def designal_device
    if user_owns_this_device?
      if ParticleService.new.publish_scan_info(designal_data)
        redirect_back fallback_location: user_path(@device.user), notice: "#{@device.name} was signalled!"
      else
        redirect_back fallback_location: user_path(@device.user), notice: "#{@device.name} could not be signalled!"
      end
    else
      redirect_to tag_path(@device), notice: 'You can\'t signal this device, it belongs to someone else.'
    end
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def user_owns_this_device?
    user_signed_in? && @device.user == current_user
  end

  def signal_data
    {
      device:    'astroscan',
      device_id: @device.device_id,
      origin:    'Web App',
      type:      'Signal',
      name:      current_user.name,
      light_r:   255,
      light_g:   255,
      light_b:   255
    }
  end

  def designal_data
    {
      device:    'astroscan',
      device_id: @device.device_id,
      origin:    'Web App',
      type:      'Designal',
      name:      current_user.name,
      light_r:   0,
      light_g:   0,
      light_b:   0
    }
  end

end
