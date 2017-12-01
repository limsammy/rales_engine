class ApplicationController < ActionController::API

  private

  def reformatted_unit_price
    { unit_price: (params[:unit_price].to_f * 100).to_i }
  end

end
