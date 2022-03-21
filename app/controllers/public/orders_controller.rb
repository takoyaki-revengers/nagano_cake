class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面を表示する(支払方法、配送先の選択)
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm #注文情報確認画面を表示する
    @cart_items = current_customer.cart_items.all
    @postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_price = @total + @postage
    if params[:order][:address] == "0" #自分の住所に送る場合
      @order = Order.new
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    elsif params[:order][:address] == "1"
      @order = Order.new
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address] == "2"
      @order = Order.new(order_params)
    else
      #flash[:notice] = "配送先を選択してください"
      @order = Order.new(order_params)
      render :new
    end
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
        params.require(:order).permit(:payment_method, :postal_code, :address, :name)
    end
end
