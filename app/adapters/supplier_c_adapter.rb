class SupplierCAdapter < Adapter

  SUPPLIER_URL = URI("https://api.myjson.com/bins/j6kzm")

  def get_supplier_uri
    SUPPLIER_URL
  end

  def id(hotel)
    hotel["id"]
  end

  def destination_id(hotel)
    hotel["destination"]
  end

  def name(hotel)
    hotel["name"]
  end

  def location(hotel)
    {
      lat: hotel["lat"],
      lng: hotel["lng"],
      address: hotel["address"],
      city: nil,
      country: nil,
    }
  end

  def description(hotel)
    hotel["info"]
  end

  def amenities(hotel)
    {
      general: hotel["amenities"],
      room: []
    }
  end

  def images(hotel)
    {
      rooms: extract_images(hotel, "rooms"),
      site: [],
      amenities: extract_images(hotel, "amenities"),
    }
  end

  def extract_images(hotel, key)
    hotel["images"][key].inject([]) do |images, metadata|
      images << { link: metadata["url"], description: metadata["description"] }
      images
    end    
  end

  def booking_conditions(hotel)
    []
  end
end
