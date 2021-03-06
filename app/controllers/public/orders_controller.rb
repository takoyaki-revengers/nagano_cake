class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面を表示する(支払方法、配送先の選択)
    @order = Order.new
  end

  def confirm #注文情報確認画面を表示する
    @cart_items = current_customer.cart_items.all #会員のカート内商品全て
    @shipping_cost = 800 #送料
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } #合計金額（送料以外）
    @total_price = @total + @shipping_cost #合計金額（送料込み）

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if params[:order][:address_option] == "0" #自分の住所の場合
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    elsif params[:order][:address_option] == "1" #登録済住所の場合
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == "2" #新しいお届け先の場合はアドレステーブルに保存まで
      @address = Address.new
      @address.customer_id = current_customer.id
      @address.post_code = @order.post_code
      @address.address = @order.address
      @address.name = @order.name
      if @address.save
      else
        flash.now[:alert] = "新しいお届け先を入力してください。"
        @order = Order.new(order_params)
        render :new
      end
    else
      flash.now[:alert] = "配送先を選択してください。"
      render :new
    end
  end

  def create #注文情報を確定する
    @cart_items = current_customer.cart_items.all #会員のカート内商品全て
    @shipping_cost = 800 #送料
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } #合計金額（送料以外）
    @total_price = @total + @shipping_cost #合計金額（送料込み)
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @customer = Customer.find(current_customer.id)

    if @order.save
      redirect_to orders_thanks_path
    else
      render :new
    end

    @cart_items = current_customer.cart_items #会員の注文詳細を登録する
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
      @cart_items.destroy_all #カート内商品を削除
  end

  def thanks #注文完了画面を表示する
  end

  def index #注文履歴一覧画面の表示
    @orders = current_customer.orders.all.page(params[:page]).per(3)
  end

  def show #注文履歴詳細画面の表示
   @order=current_customer.orders.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :total_payment, :payment_method, :post_code, :address, :name, :shipping_cost)
    end

end

