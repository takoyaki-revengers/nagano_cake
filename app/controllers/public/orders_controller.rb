class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #注文情報入力画面を表示する(支払方法、配送先の選択)
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm #注文情報確認画面を表示する
    @cart_items = current_customer.cart_items.all #会員のカート内商品全て
    @postage = 800 #送料
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } #合計金額（送料以外）
    @total_price = @total + @postage #合計金額（送料込み）
    
    if params[:order][:address] == "0" #自分の住所の場合
      @order = Order.new
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    elsif params[:order][:address] == "1" #登録済住所の場合
      @order = Order.new
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address] == "2" #新しいお届け先の場合
      @order = Order.new(order_params)
    else
      #flash[:notice] = "配送先を選択してください"
      @order = Order.new(order_params)
      render :new
    end
  end

  def create #注文情報を確定する
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if @order.save
      #flash[:notice] = "注文を受け付けました"
      
      if params[:order][:address] == "2" #新しいお届け先を選択した場合、その住所を登録する
        @address = Address.new
        @address.customer_id = current_customer.id
        @address.name = @order.name
        @address.post_code = @order.post_code
        @address.address = @order.address
        @address.save
      end
      
        @cart_items = current_customer.cart_items #会員の注文詳細を登録する
        @cart_items.each do |cart_item|
        @orded_item = Order_Detail.new
        @orded_item.item_id = cart_item.item_id
        @orded_item.order_id = @order.id
        @orded_item.total_payment = cart_item.item.total_payment
        @orded_item.amount = cart_item.amount
        @orded_item.save
      end
      #@cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      @order = Order.new(order_params)
      render :new
    end
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
