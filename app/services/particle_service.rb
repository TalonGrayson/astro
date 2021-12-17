class ParticleService

  def initialize
    Particle.configure do |c|
      c.access_token = ENV['PARTICLE_ACCESS_TOKEN']
    end
  end

  def call
    Particle.devices.map { |device| device.name }
  end

  def get_devices
    Particle.devices.map { |device| device.name }
  end

  def publish_scan_info(data)

    Particle.publish(
        name: 'event_info',
        data: data,
        private: true
    )
  end

end
