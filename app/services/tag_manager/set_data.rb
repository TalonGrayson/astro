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
          tag = TagManager::CreateTag.new(parsed_params['id'], parsed_params['device_id']).call
        end

        if tag.present?
          {
            device:    parsed_params['device'],
            device_id: parsed_params['device_id'],
            origin:    tag.origin,
            type:      tag.variety,
            name:      tag.name,
            light_r:   tag.light_rgb.split(',')[0].to_i,
            light_g:   tag.light_rgb.split(',')[1].to_i,
            light_b:   tag.light_rgb.split(',')[2].to_i
          }
        end
      end
    end

  end
end
