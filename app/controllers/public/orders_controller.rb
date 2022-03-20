class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create

  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private
  def

  end

end
