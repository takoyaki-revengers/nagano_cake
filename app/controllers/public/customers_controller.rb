class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to customers_my_page_path(@customer)
    else
      flash.now[:alert] = "会員情報を入力してください。"
      render :edit
    end
  end

  def unsubscribe #退会確認画面の表示
  end

  def withdraw #退会フラグを切り替える
    @customer = current_customer
    @customer.update(is_deletd: true) #is_deletedカラムの退会フラグを退会（true）に更新する
    reset_session #ログアウトさせる
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :telephone, :email)
  end

end
