class VideosController < ApplicationController
  def new
  end

  def create
    @vidya = Video.new(params.require(:video_data).permit(:name,:url))
    @vidya.save
    redirect_to @vidya
  end

  def show
    @vidya = Video.find(params[:id])
  end

  def index
    @vidyas = Video.all
  end
end
