class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
   if @genre.save
    flash[:notice] = "新しいジャンルを追加しました。"
    redirect_to request.referer
   end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
   if @genre.update(genre_params)
    flash[:notice] = "ジャンルを編集しました。"
   end
    redirect_to admin_genres_path
  end


  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
