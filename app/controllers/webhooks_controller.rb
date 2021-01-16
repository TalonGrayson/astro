class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def receive
    render json: { success: true }

    data = TagManager::SetData.new(params[:data]).call

    ParticleService.new.publish_scan_info(data)
    #head :ok
  end

  private

  def webhook_params
    params.require(:event).permit(:data)
  end

  def permitted?
    false
  end

end
