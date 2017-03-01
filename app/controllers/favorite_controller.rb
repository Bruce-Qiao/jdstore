class FavoriteController < ApplicationController
  layout "buy"

  def index
    @products = current_user.favorite_products
  end

end
