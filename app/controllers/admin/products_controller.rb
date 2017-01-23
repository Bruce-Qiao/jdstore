class Admin::ProductsController < ApplicationController

  layout "admin"

  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin

  def require_is_admin
    if !current_user.admin?
      flash[:alert]= 'You are not admin!'
      redirect_to root_path
    end
  end

  def show
    @product=Product.find(params[:id])
  end

  def index
    @products=Product.all
  end

  def new
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product=Product.find(product_params)
  end

  def update
    @product=Product.find(product_params)
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product=Product.find(product_params)

    @product.destroy

    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end

end