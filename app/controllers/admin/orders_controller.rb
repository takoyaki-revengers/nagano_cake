class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])

  end



  def show
  end

  def update
  end


end
