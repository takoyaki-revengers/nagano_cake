class Admin::OrderDetailsController < ApplicationController

  def update
    order = Oder.find(params[:order_id])
    order_details = order.order_details
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)

    if order_details.where(making_status: "製作完了").count == order_details.count
      order.update(status: "発送準備中")
    elsif order_details.where(making_status: "製作中").count >= 1
      order.update(status: "製作中")
    end

    redirect_to request.referer
  end



 private
    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end

end
