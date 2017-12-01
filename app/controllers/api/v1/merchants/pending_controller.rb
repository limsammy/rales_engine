module Api
  module V1
    module Merchants
      class PendingController < ApplicationController
        def index
          render json: Merchant.find(params[:id]).pending
        end
      end
    end
  end
end