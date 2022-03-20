class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
  end


  private
  def customer_params
    params.require(:customer).oermit(:familiy_name, :first_name, :familiy_name_kana, :first_name_kana, :post_code, :address, :email, :withdraw )
  end
end
