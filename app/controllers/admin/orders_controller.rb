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
    @order = Order.find(params[:id])
    @order_details = @order.order_details
   if @order.update(order_params)
     flash[:notice] = "注文ステータスを更新しました。"
   end
   if @order.status == "入金確認"
     @order_details.update_all(making_status: 1)
    redirect_to admin_order_path(@order)
   else
     redirect_to request.referer
   end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end


end
