class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:name, :url)
    end
end
