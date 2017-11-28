module Api
  module V1
    class InvoiceItemsController < ApplicationController

      def index
        render json: InvoiceItem.all
      end

    end
  end
end
