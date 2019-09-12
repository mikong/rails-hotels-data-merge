require 'net/http'

class Adapter

  def initialize(params = {})
    @hotel_ids = params[:hotel_ids] || []
    @destination_id = params[:destination_id]
    @raw_data = []
  end

  def get_raw_data
    return @raw_data  unless @raw_data.empty?

    fetch_raw_data
    @raw_data
  end

  def fetch_raw_data
    response = Net::HTTP.get(get_supplier_uri)
    @raw_data = JSON.parse response
  end

  def get_hotels
    return {} if @destination_id.blank? && @hotel_ids.empty?

    raw_data = get_raw_data

    raw_hotels = if @destination_id.present?
      get_raw_hotels_by_destination(raw_data)
    else
      get_raw_hotels_by_ids(raw_data)
    end

    raw_hotels.reduce({}) do |hotels, raw_hotel|
      hotels[id(raw_hotel)] = output(raw_hotel)
      hotels
    end    
  end

  def get_raw_hotels_by_ids(raw_data)
    raw_data.select { |h| @hotel_ids.include? id(h) }
  end

  def get_raw_hotels_by_destination(raw_data)
    raw_data.select { |h| destination_id(h) == @destination_id }
  end

  def output(hotel)
    {
      id: id(hotel),
      destination_id: destination_id(hotel),
      name: name(hotel),
      location: location(hotel),
      description: description(hotel),
      amenities: amenities(hotel),
      images: images(hotel),
      booking_conditions: booking_conditions(hotel),
    }
  end

  def sanitize_text(text)
    text.strip.titleize.downcase
  end

end
