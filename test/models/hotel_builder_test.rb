require 'test_helper'

class HotelBuilderTest < ActiveSupport::TestCase
  setup do
    @suppliers_hotel_a = {
      A: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas A", :location=>{:lat=>nil, :lng=>nil, :address=>"Short", :city=>nil, :country=>"Singapore"}, :description=>"Description A", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      B: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas B", :location=>{:lat=>nil, :lng=>nil, :address=>"Longer than short", :city=>nil, :country=>"Singapore"}, :description=>"Description B", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      C: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas C", :location=>{:lat=>nil, :lng=>nil, :address=>"Longest of the three suppliers", :city=>nil, :country=>"Singapore"}, :description=>"Description C", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      D: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas D", :location=>{:lat=>nil, :lng=>nil, :city=>nil, :country=>"Singapore"}, :description=>"Description C", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["All children are welcome."]},
    }
    @suppliers_hotel_b = {
      A: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas A", :location=>{:lat=>nil, :lng=>nil, :address=>"Longer than short AAA", :city=>nil, :country=>"Singapore"}, :description=>"Description A", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      B: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas B", :location=>{:lat=>nil, :lng=>nil, :address=>"Longest of the three suppliers AAA", :city=>nil, :country=>"Singapore"}, :description=>"Description B", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      C: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas C", :location=>{:lat=>nil, :lng=>nil, :address=>"Short AAA", :city=>nil, :country=>"Singapore"}, :description=>"Description C", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
      D: {:id=>"iJhz", :destination_id=>5432, :name=>"Beach Villas D", :location=>{:lat=>nil, :lng=>nil, :address=>nil, :city=>nil, :country=>"Singapore"}, :description=>"Description C", :amenities=>{:general=>["outdoor pool", "indoor pool", "business center", "childcare"], :room=>["tv", "coffee machine", "kettle", "hair dryer", "iron"]}, :images=>{:rooms=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", :description=>"Double room"}, {:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", :description=>"Double room"}], :site=>[{:link=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", :description=>"Front"}], :amenities=>[]}, :booking_conditions=>["One child under 12 years stays free of charge when using existing beds."]},
    }
  end

  test "prioritize name and description" do
    hotel_builder = HotelBuilder.new(suppliers_hotel: @suppliers_hotel_a)
    hotel = hotel_builder.build
    assert_equal("Beach Villas C", hotel[:name])
    assert_equal("Description B", hotel[:description])
  end

  test "obtain longest address" do
    builder_a = HotelBuilder.new(suppliers_hotel: @suppliers_hotel_a)
    hotel = builder_a.build
    assert_equal("Longest of the three suppliers", hotel[:location][:address])

    builder_b = HotelBuilder.new(suppliers_hotel: @suppliers_hotel_b)
    hotel = builder_b.build
    assert_equal("Longest of the three suppliers AAA", hotel[:location][:address])
  end
end
