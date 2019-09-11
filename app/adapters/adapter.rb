class Adapter

  def initialize(data)
    @data = data
  end

  def output
    {
      id: id,
      destination_id: destination_id,
      name: name,
      location: location,
      description: description,
      amenities: amenities,
      images: images,
      booking_conditions: booking_conditions,
    }
  end

end
