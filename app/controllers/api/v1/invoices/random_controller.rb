module Api
  module V1
    module Invoices
      class RandomController < ApplicationController

        def show
          render json: Invoice.all.sample
        end

      end
    end
  end
end
