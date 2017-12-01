module Api
  module V1
    module Items
      class RandomController < ApplicationController

        def show
          render json: Item.all.sample
        end

      end
    end
  end
end
