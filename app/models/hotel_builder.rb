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
    # address: [:B, :A, :C],
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
      suppliers.each do |supplier| # :B, :C, :A
        value = @suppliers_hotel.dig(supplier, :location, field)
        if value.present?
          @data[:location][field] = value
          break
        end
      end
    end

    get_longest_address
  end

  def get_longest_address
    @data[:location][:address] = @suppliers_hotel.values
      .collect { |hotel| hotel[:location][:address] }
      .compact
      .max_by { |address| address.length }
  end

  def populate_amenities
    @data[:amenities] = {}

    [:general, :room].each do |amenity_type|
      amenity_group = @suppliers_hotel.values.reduce([]) do |amenities, hotel|
        amenities.concat(hotel[:amenities][amenity_type])
      end
      @data[:amenities][amenity_type] = amenity_group.uniq { |a| a.delete(" ") }
    end

    @data[:amenities][:general].delete_if do |amenity|
      @data[:amenities][:room].map { |a| a.delete(" ") }.include?(amenity.delete(" "))
    end
  end

  def populate_images
    @data[:images] = {}

    [:rooms, :site, :amenities].each do |image_type|
      image_group = @suppliers_hotel.values.reduce([]) do |images, hotel|
        images.concat(hotel[:images][image_type])
      end
      @data[:images][image_type] = image_group.uniq { |image| image[:link] }
    end
  end
end
