module Api
  module V1
    module Merchants
      class MostRevenueController < ApplicationController
        def index
          render json: Merchant.most_revenue(params[:quantity])
        end

        private

        def merchant_params
          params.permit(:id, :name, :created_at, :updated_at)
        end
      end
    end
  end
end