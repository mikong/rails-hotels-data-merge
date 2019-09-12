class HotelBuilder

  PRIORITIES = {
    id: [:A, :B, :C],
    destination_id: [:A, :B, :C],
    name: [:C, :B, :A],
    # location: special logic
    description: [:B, :A],
    # amenities: special logic
    # images: special logic
    booking_conditions: [:B],
  }  
  
  LOCATION_PRIORITIES = {
    lat: [:C, :A, :B],
    lng: [:C, :A, :B],
    address: [:B, :A, :C],
    city: [:A],
    country: [:B, :A],    
  }

  def initialize(options = {})
    @suppliers_hotel = options[:suppliers_hotel]
    @data = {}
  end

  def build
    populate_fields
    populate_location
    populate_amenities
    populate_images

    @data
  end

  def populate_fields
    PRIORITIES.keys.each do |field|
      @data[field] = get_value(field, @suppliers_hotel)
    end
  end

  def get_value(field, data, priorities = PRIORITIES)
    priorities[field].each do |supplier|
      value = data.dig(supplier, field)
      return value if value.present?
    end
  end

  def populate_location
    @data[:location] = {}

    LOCATION_PRIORITIES.each do |field, suppliers|
      @data[:location][field] = nil
      suppliers.each do |supplier|
        value = @suppliers_hotel.dig(supplier, :location, field)
        if value.present?
          @data[:location][field] = value
          break
        end
      end
    end
  end

  def populate_amenities
    # TODO
  end

  def populate_images
    # TODO
  end
end
