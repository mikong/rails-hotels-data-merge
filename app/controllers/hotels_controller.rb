class HotelsController < ApplicationController

  def index
    hotels = HotelsQuery.new(hotels_params).call
    render json: hotels
  end

private

  def hotels_params
    params.permit(:hotels, :destination)
  end

end
