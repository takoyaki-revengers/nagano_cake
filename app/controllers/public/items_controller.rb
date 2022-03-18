class Public::ItemsController < ApplicationController
  def index
    # @items = Item.all
    @items = Item.page(params[:page])
  end

  def show
  end
end
