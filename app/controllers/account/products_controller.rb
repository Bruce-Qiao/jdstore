class Account::ProductsController < ApplicationController

  layout "sell"

  before_action :authenticate_user!

  def index
     @products = current_user.products.order("id DESC")
  end

  def new
     @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    # price_limit = (@product.taoprice*0.5)
    # if @product.price <= price_limit
      if @product.save
        redirect_to account_products_path
      else
        render :new
      end
    # else
    #   render :new, warning: '售价不能超过淘宝价的一半！'
    # end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    # price_limit = (@product.taoprice*0.5)
    # if @product.price <= price_limit
      if @product.update(product_params)
        redirect_to account_products_path
      else
        render :edit
      end
    # else
    #   render :new, warning: '售价不能超过淘宝价的一半！'
    # end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to account_products_path, alert: 'Product deleted!'
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :taoprice, :sort)
  end

end
