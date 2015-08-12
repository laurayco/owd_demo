class VideosController < ApplicationController
  def new
    @error = :error
  end

  def create
    @URL = params[:video_data][:url]
    if not /DURP/ =~ @URL then
      redirect_to :controller=>"videos", :action => "new", :error=>"Invalid URL"
    else
      @vidya = Video.new(params.require(:video_data).permit(:name,:url))
      @vidya.save
      redirect_to @vidya
    end
  end

  def show
    @vidya = Video.find(params[:id])
  end

  def index
    @vidyas = Video.all
  end
end
