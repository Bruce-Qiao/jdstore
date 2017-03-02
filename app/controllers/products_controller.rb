class ProductsController < ApplicationController
  layout "buy"

  before_action :authenticate_user!, only: [:add_to_cart, :favorite]
  before_action :validate_search_key, only: [:search]

  def index
    @products = case params[:sort]
                when 'computer'
                  sort_name = "电脑及周边商品"
                  Product.where(:sort => "computer").order("created_at DESC")
                when 'furniture'
                  sort_name = "家具及家居商品"
                  Product.where(:sort => "furniture").order("created_at DESC")
                when 'office'
                  Product.where(:sort => "office").order("created_at DESC")
                when 'other'
                  Product.where(:sort => "other").order("created_at DESC")
                else
                  Product.all.order("created_at DESC")
                end
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if @product.quantity.present? && @product.quantity > 0
      if !current_cart.products.include?(@product)
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "成功将#{@product.title}加入购物车！"
        redirect_to :back
      else
        flash[:notice] = "该商品已经加入购物车了。"
        redirect_to :back
      end
    else
      flash[:warning] = "该商品已经没有库存了！"
      redirect_to :back
    end
  end

  def favorite
    @product = Product.find(params[:id])
    type = params[:type]

    if type == "favorite"
      current_user.favorite_products << @product
      redirect_to :back
    elsif type == "unfavorite"
      current_user.favorite_products.delete(@product)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def search
    if @query_string.present?
      @products = search_params
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  private

  def search_params
    Product.ransack({:title_or_description_cont => @query_string}).result(distinct: true)
  end

end
