class Public::AddressesController < ApplicationController
  #before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to request.referer
    else
      @customer = current_customer
      @addresses = @customer.addresses
      render 'index'
    end
  end


  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to "/addresses"
    else
      render "edit"
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer
  end

  def full_address　#注文情報入力画面のお届け先表示用
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  private

  def address_params
    params.require(:address).permit(:name, :post_code, :address)
  end
end
