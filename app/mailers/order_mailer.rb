class OrderMailer < ApplicationMailer

  def notify_order_placed(order)
    @order       = order
    @user        = order.user
    @supplier    = User.find(@order.product_lists.first.user_id)
    @product_lists = @order.product_lists

    mail(to: @supplier.email , subject: "[HALFprice] 您有了新的订单，以下是订单明细 #{order.token}")
    mail(to: @user.email , subject: "[HALFprice] 感谢您完成本次的下单，以下是您这次购物明细 #{order.token}")
  end

  def apply_cancel(order)
    @order       = order
    @user        = order.user
    @supplier    = User.find(@order.product_lists.first.user_id)
    @product_lists = @order.product_lists

    mail(to: @supplier.email , subject: "[HALFprice] 用户#{order.user.email}申请取消订单 #{order.token}")
  end

  def notify_ship(order)
    @order        = order
    @user         = order.user
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[HALFprice] 您的订单 #{order.token}已发货")
  end

  def notify_cancel(order)
    @order        = order
    @user         = order.user
    @product_lists = @order.product_lists

    mail(to: @user.email, subject: "[HALFprice] 您的订单 #{order.token}已取消")
  end

end
