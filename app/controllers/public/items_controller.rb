class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: "true" ).page(params[:page]).per(8) #ステータス判別、ページネーション
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    # @customer_id = current_customer.id
    @cart_item = CartItem.new
  end




end
