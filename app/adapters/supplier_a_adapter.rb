class SupplierAAdapter < Adapter

  SUPPLIER_URL = URI("https://api.myjson.com/bins/gdmqa")

  def get_supplier_uri
    SUPPLIER_URL
  end

  def id(hotel)
    hotel["Id"]
  end

  def destination_id(hotel)
    hotel["DestinationId"]
  end

  def name(hotel)
    hotel["Name"]
  end

  def location(hotel)
    {
      lat: hotel["Latitude"],
      lng: hotel["Longitude"],
      address: hotel["Address"],
      city: hotel["City"],
      country: country_code_to_country(hotel["Country"]),
    }
  end

  def description(hotel)
    hotel["Description"]
  end

  def amenities(hotel)
    {
      general: hotel["Facilities"],
      room: []
    }
  end

  def images(hotel)
    {
      rooms: [],
      site: [],
      amenities: [],
    }
  end

  def booking_conditions(hotel)
    []
  end

  # TODO: Move to a separate class
  def country_code_to_country(code)
    # TODO: Implement country code to country
    "Singapore"
  end
end
