class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def receive
    render json: {success: true}

    parsed_params = ActiveSupport::JSON.decode(params[:data])

    @tag = Tag.find_by_tag_hex parsed_params['id']

    @tag.update(last_seen: DateTime.now)

    data = {
        device:  parsed_params['device'],
        origin:  @tag.origin,
        type:    @tag.variety,
        name:    @tag.name,
        light_r: @tag.light_rgb.split(',')[0].to_i,
        light_g: @tag.light_rgb.split(',')[1].to_i,
        light_b: @tag.light_rgb.split(',')[2].to_i
    }

    ParticleService.new.publish_scan_info(data)

    #head :ok
  end

end
