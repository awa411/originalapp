class UsersController < ApplicationController
  def show
    @categories = Category.all
    @p = Article.ransack(params[:q])
    @user = User.find(params[:id])
    @articles = Article.where(user_id: params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:id)
  end
end
