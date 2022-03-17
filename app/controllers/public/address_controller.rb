class Public::AddressController < ApplicationController
  #before_action :authenticate_customer!

  def index
    @customer = current_customer
    @address = Address.new
    @addresses = @customer.addresses
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

  private

  def address_params
    params.require(:address).permit(:name, :post_code, :address)
  end

end
