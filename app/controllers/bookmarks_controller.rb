class BookmarksController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    current_user.bookmark(@article)
    flash[:alert] = 'お気に入り登録が完了しました'
    # redirect_back fallback_location: root_path, success: 'ブックマークしました'
  end

  def destroy
    @article = current_user.bookmarks.find_by(id: params[:id]).article
    current_user.unbookmark(@article)
    flash[:alert] = 'お気に入り登録を解除しました'
    # redirect_back fallback_location: root_path, success: 'ブックマークを外しました'
  end
end
