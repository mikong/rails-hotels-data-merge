class SupplierCAdapter < Adapter

  def id
    @data["id"]
  end

  def destination_id
    @data["destination"]
  end

  def name
    @data["name"]
  end

  def location
    {
      lat: @data["lat"],
      lng: @data["lng"],
      address: @data["address"],
      city: nil,
      country: nil,
    }
  end

  def description
    @data["info"]
  end

  def amenities
    {
      general: @data["amenities"],
      room: []
    }
  end

  def images
    {
      rooms: extract_images("rooms"),
      site: [],
      amenities: extract_images("amenities"),
    }
  end

  def extract_images(key)
    @data["images"][key].inject([]) do |images, metadata|
      images << { link: metadata["url"], description: metadata["description"] }
      images
    end    
  end

  def booking_conditions
    []
  end
end
