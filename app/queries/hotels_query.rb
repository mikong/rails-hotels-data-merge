class HotelsQuery
  def initialize(params = {})
    @ids = params[:hotels] || []
    @destination_id =  if params[:destination].present?
      params[:destination].to_i
    end
  end

  def filter_params
    if @destination_id.present?
      { destination_id: @destination_id }
    else
      { hotel_ids: @ids }
    end
  end

  def call
    hotels = []

    # many hotels per supplier
    suppliers_hotels = {
      A: SupplierAAdapter.new(filter_params).get_hotels,
      B: SupplierBAdapter.new(filter_params).get_hotels,
      C: SupplierCAdapter.new(filter_params).get_hotels,
    }

    hotel_ids = suppliers_hotels.reduce([]) { |arr, (k, v)| arr.concat(v.keys) }.uniq

    hotel_ids.each do |hotel_id|
      # one hotel per supplier
      suppliers_hotel = {}

      suppliers_hotels.each do |supplier_id, supplier_hotels|
        hotel = supplier_hotels[hotel_id]
        suppliers_hotel[supplier_id] = hotel unless hotel.nil?
      end

      hotel = HotelBuilder.new(suppliers_hotel: suppliers_hotel).build
      hotels << hotel
    end

    hotels
  end
end
