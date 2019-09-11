class SupplierAAdapter < Adapter

  def id
    @data["Id"]
  end

  def destination_id
    @data["DestinationId"]
  end

  def name
    @data["Name"]
  end

  def location
    {
      lat: @data["Latitude"],
      lng: @data["Longitude"],
      address: @data["Address"],
      city: @data["City"],
      country: country_code_to_country(@data["Country"]),
    }
  end

  def description
    @data["Description"]
  end

  def amenities
    {
      general: @data["Facilities"],
      room: []
    }
  end

  def images
    {
      rooms: [],
      site: [],
      amenities: [],
    }
  end

  def booking_conditions
    []
  end

  # TODO: Move to a separate class
  def country_code_to_country(code)
    # TODO: Implement country code to country
    "Singapore"
  end
end
