module Api
  module V1
    module InvoiceItems
      class RandomController < ApplicationController

        def show
          render json: InvoiceItem.all.sample
        end

      end
    end
  end
end
