class ArticlesController < ApplicationController

  before_action :see_params_headers, :authenticate_user!
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :find_user, only: [:create, :update]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order(created_at: :desc)
    render json: @articles, include: %w(user)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    render json: @article, include: %w(user)
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = @user
    puts '----> create', @article
    if @article.save
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def find_user
      @user = User.find(params[:data][:relationships][:user][:data][:id])
    end

    def article_params
      puts '============= before serialization', params.inspect
      # ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
      # puts '============= after serialization', params.inspect
      params.require(:data).require(:attributes).permit(:body)
    end
end
