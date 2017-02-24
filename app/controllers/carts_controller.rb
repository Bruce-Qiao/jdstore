class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @cart_item = current_cart.cart_items.find(params[:id])
    # @user = User.find(@cart_item.product.user_id)
  end

  def clean
    current_cart.clean!
    flash[:warning]="已经清空购物车。"
    redirect_to :back
  end

  def checkout
    @order=Order.new
  end

end
