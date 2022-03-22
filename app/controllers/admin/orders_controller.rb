class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])

  end



  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
  end

  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    order.update(order_params)
    order_details.update_all(making_status: "製作待ち") if order.status == "入金確認"
    redirect_to request.referer
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end


end
