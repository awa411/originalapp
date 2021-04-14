class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destoy]
  before_action :article_find, only: [:show, :edit, :update, :destroy]
  before_action :is_current_user, only: [:edit, :update, :destroy]
  before_action :search_articles, only: [:index, :search, :show, :new, :edit, :update]
  before_action :category_obj, only: [:index, :search, :show, :new, :edit, :update]
  def index
    @articles = Article.includes(:user).order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      @image = url_for(@article.images[0])
      @user = @article.user
      @category_name = Category.find(@article.category_id).name
      @user_path = user_path(@article.user_id)
      @category_path = articles_search_path(@q, :'q[category_id_eq' => "#{@article.category_id}")
      @article_path = article_path(@article.id)

      ActionCable.server.broadcast 'article_channel', article: @article, user: @user, category_name: @category_name, image: @image,
                                                      user_path: @user_path, category_path: @category_path, article_path: @article_path
      redirect_to root_path
    else
      search_articles
      category_obj
      render :new
    end
  end

  def show
  end

  def edit
    @title = @article.title
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result.includes(:user).order('created_at DESC')
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :category_id, images: []).merge(user_id: current_user.id)
    end

    def search_articles
      @p = Article.ransack(params[:q])
    end

    def category_obj
      @categories = Category.all
    end

    def article_find
      @article = Article.find(params[:id])
    end

    def judge_signed_in
      unless user_signed_in?
        ridirect_to new_user_registration_path
      end
    end

    def is_current_user
      unless current_user.id == @article.user_id
        redirect_to new_user_registration_path
      end
    end
end
