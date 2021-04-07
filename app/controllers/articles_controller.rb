class ArticlesController < ApplicationController
  before_action :search_articles, only: [:index, :search, :show, :new, :edit]
  before_action :category_obj, only: [:index, :search, :show, :new, :edit]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if@article.update(article_params)
      redirect_to article_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result
  end

  private
    def article_params
      params.require(:article).permit(:image, :title, :text, :category_id).merge(user_id: current_user.id)
    end

    def search_articles
      @p = Article.ransack(params[:q])
    end

    def category_obj
      @categories = Category.all
    end
end
