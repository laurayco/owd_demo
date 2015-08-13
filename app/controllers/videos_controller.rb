class VideosController < ApplicationController
  def new
    if params.has_key?(:error)
      @errorzy = params[:error]
      @bad_url = params[:bad_url]
    end
  end

  def valid_url(url)
    return nil
  end

  def create
    @URL = valid_url params[:video_data][:url]
    if not @URL then
      redirect_to :controller=>"videos", :action => "new", :error=>"Invalid URL", :bad_url => params[:video_data][:url]
    else
      @vidya = Video.new :name=>params[:name], url:@URL
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
