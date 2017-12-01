module Api
  module V1
    module Items
      class FindController < ApplicationController

        def show
          render json: Item.find_by(item_params)
        end

        def index
          render json: Item.where(item_params)
        end

        private

        def item_params
          return reformatted_unit_price if params[:unit_price]
          params.permit(:id, :name, :description, :merchant_id, :created_at, :updated_at)
        end

      end
    end
  end
end
