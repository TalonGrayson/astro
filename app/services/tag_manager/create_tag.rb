module TagManager
  class CreateTag

    def initialize(tag_id, device_id)
      @tag_id    = tag_id
      @device_id = device_id
    end

    def call
      device = Device.find_by_device_id(@device_id)

      if device.present?
        tag = Tag.new(
          tag_hex: @tag_id,
          user_id: device.user.id
        )

        if tag.save
          puts "New tag created for device: #{device.name}"
          return tag
        else
          puts "Tag could not be created: #{tag.errors}"
        end
      else
        puts 'Device does not exist or has not been registered'
      end
    end

  end
end
