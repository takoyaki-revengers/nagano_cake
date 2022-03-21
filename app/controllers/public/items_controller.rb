class Public::ItemsController < ApplicationController
  def index
    # @items = Item.all
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @customer_id = current_customer.id
    @cart_item = CartItem.new
  end




end
