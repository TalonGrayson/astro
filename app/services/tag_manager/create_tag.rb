module TagManager
  class CreateTag

    def initialize(tag_id, device_id)
      @tag_id = tag_id
      @device_id = device_id
    end

    def call
      Tag.create(
        tag_hex: tag_id,
      )
    end

  end
end
