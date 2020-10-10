class ParticleService

  def initialize
    Particle.configure do |c|
      c.access_token = ENV['PARTICLE_ACCESS_TOKEN']
    end
  end

  def call
    Particle.devices.map { |device| device.name }
  end

end
