module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController

        def index
          render json: {"total_revenue" => Merchant.total_revenue(params[:date]) }
        end

        def show
          render json: {"revenue" => Merchant.total_revenue(params[:date],params[:id]) }
        end

      end
    end
  end
end
