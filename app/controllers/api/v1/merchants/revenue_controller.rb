module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController

        def show
          render json: {"revenue" => Merchant.total_revenue(params[:id]).to_s }
        end

      end
    end
  end
end
