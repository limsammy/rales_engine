module Api
  module V1
    module Items
      class BestDayController < ApplicationController

        def show
          item = Item.find(params[:id])
          render json: item.best_day, serializer: BestDaySerializer
        end

      end
    end
  end
end