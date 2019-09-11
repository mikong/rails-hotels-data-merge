class SupplierBAdapter < Adapter

  def id
    @data["hotel_id"]
  end

  def destination_id
    @data["destination_id"]
  end

  def name
    @data["hotel_name"]
  end

  def location
    {
      lat: nil,
      lng: nil,
      address: @data["location"]["address"],
      city: nil,
      country: @data["location"]["country"],
    }
  end

  def description
    @data["details"]
  end

  def amenities
    {
      general: @data["amenities"]["general"],
      room: @data["amenities"]["room"],
    }
  end

  def images
    {
      rooms: extract_images("rooms"),
      site: extract_images("site"),
      amenities: [],
    }
  end

  def extract_images(key)
    @data["images"][key].inject([]) do |images, metadata|
      images << { link: metadata["link"], description: metadata["caption"] }
      images
    end    
  end

  def booking_conditions
    @data["booking_conditions"]
  end
end
