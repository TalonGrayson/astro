module TagManager
  class SetData

    def initialize(params)
      @params = params
    end

    def call
      if @params == 'test-event'
        {
          device:  'astroscan',
          origin:  'Particle',
          type:    'Webhook',
          name:    'Test Event',
          light_r: 255,
          light_g: 255,
          light_b: 255
        }
      else
        parsed_params = ActiveSupport::JSON.decode(@params)

        tag = Tag.find_by_tag_hex parsed_params['id']

        if tag.present?

          tag.update(last_seen: DateTime.now, deleted: false)

        else

          TagManager::CreateTag.new.call

        end

        {
          device:  parsed_params['device'],
          origin:  tag.origin,
          type:    tag.variety,
          name:    tag.name,
          light_r: tag.light_rgb.split(',')[0].to_i,
          light_g: tag.light_rgb.split(',')[1].to_i,
          light_b: tag.light_rgb.split(',')[2].to_i
        }
      end
    end

  end
end
