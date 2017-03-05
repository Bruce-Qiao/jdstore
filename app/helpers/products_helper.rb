module ProductsHelper

  def render_product_description(product)
    simple_format(product.description)
  end

  def discount_percentage(product)
    (product.taoprice - product.price)*100/product.taoprice
  end

  def render_product_status(product)
    if product.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", :class => "fa fa-globe")
    end
  end

end
