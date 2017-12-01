module Api
  module V1
    module InvoiceItems
      class FindController < ApplicationController

        def show
          render json: InvoiceItem.find_by(invoice_item_params)
        end

        private

        def invoice_item_params
          return  reformatted_unit_price if params[:unit_price]
          params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at)
        end

      end
    end
  end
end
