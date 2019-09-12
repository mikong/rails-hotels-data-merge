class SupplierBAdapter < Adapter

  SUPPLIER_URL = URI("https://api.myjson.com/bins/1fva3m")

  def get_supplier_uri
    SUPPLIER_URL
  end

  def id(hotel)
    hotel["hotel_id"]
  end

  def destination_id(hotel)
    hotel["destination_id"]
  end

  def name(hotel)
    hotel["hotel_name"]
  end

  def location(hotel)
    {
      lat: nil,
      lng: nil,
      address: hotel["location"]["address"],
      city: nil,
      country: hotel["location"]["country"],
    }
  end

  def description(hotel)
    hotel["details"]
  end

  def amenities(hotel)
    {
      general: hotel["amenities"]["general"].map { |s| sanitize_text(s) },
      room: hotel["amenities"]["room"].map { |s| sanitize_text(s) },
    }
  end

  def images(hotel)
    {
      rooms: extract_images(hotel, "rooms"),
      site: extract_images(hotel, "site"),
      amenities: [],
    }
  end

  def extract_images(hotel, key)
    hotel["images"][key].inject([]) do |images, metadata|
      images << { link: metadata["link"], description: metadata["caption"] }
      images
    end    
  end

  def booking_conditions(hotel)
    hotel["booking_conditions"]
  end
end
