module ProductsHelper

  def render_product_description(product)
    simple_format(product.description)
  end

  def discount_percentage(product)
    (product.taoprice - product.price)*100/product.taoprice
  end

end
