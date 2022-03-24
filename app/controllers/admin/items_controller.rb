class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規商品の登録が完了しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "商品の情報を入力してください。"
      render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品の更新が完了しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "商品の情報を入力してください。"
      render "new"
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id,:name,:introduction,:price,:is_active,:image)
  end


end
