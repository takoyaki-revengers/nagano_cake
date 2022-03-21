class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面を表示する(支払方法、配送先の選択)
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm #注文情報確認画面を表示する
    @order = current_customer.Order.all

  end

  def create #注文情報を確定する
  end

  def thanks #注文完了画面を表示する
  end

  def index #注文履歴一覧画面の表示
    @orders = current_customer.orders.all
  end

  def show #注文履歴詳細画面の表示
    @order = current_customer.orders.find(params[:id])
  end

  private
    def order_params
      prams.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end
