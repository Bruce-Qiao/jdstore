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

    if @product.price <= (@product.taoprice * 0.5)
      if @product.save
        redirect_to account_products_path, alert: 'Product created!'
      else
        render :new
      end
    else
      flash[:warning]="售价不能超过淘宝价的一半！"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])


      if @product.update(product_params)
        if @product.price <= (@product.taoprice * 0.5)
          redirect_to account_products_path, alert: 'Product updated!'
        else
          flash[:warning]="售价不能超过淘宝价的一半！"
          render :edit
        end
      else
        render :edit
      end

  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to account_products_path, alert: 'Product deleted!'
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :taoprice, :sort, :is_hidden)
  end

end
