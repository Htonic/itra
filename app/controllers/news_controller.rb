class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @news = News.all.to_a
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @news = News.find(params[:id])
  end
  # GET /comments/new
  def new
    @news = News.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @news = News.create(body: news_params[:body],title: news_params[:title],campaign_id:params[:campaign_id])
    puts params[:campaign_id], "||||||", news_params
    redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to comments_url}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def news_params
    params.require(:news).permit(:id,:title, :body, :campaign_id, :image)
  end
end

