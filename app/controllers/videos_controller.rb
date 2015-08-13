class VideosController < ApplicationController

  def valid_url(url)
    @default_value = nil
    @match = /^(?:https?\:\/\/)?(?:www\.)?youtube\.com\/(?:[^?]+)\?(.+)$/.match(url)
    if @match then
      @query = @match.captures[0]
      @id_start_index = @query.index 'v='
      if @id_start_index.nil? then
        return @default_value
      end
      @id_start_index += 2
      @id_end_index = @query.index '&', @id_start_index
      if @id_end_index.nil? then
        @id_end_index = @query.length
      end
      return @query[@id_start_index,@id_end_index-@id_start_index]
    else
      @match = /^(?:https?\:\/\/)?(?:www\.)?youtu\.be\/([^?]+)(?:.+)$/.match(url)
      if @match then
        return @match.captures[0]
      else
        return @default_value
      end
    end
  end

  def index
    @title = "All Videos"
    @vidyas = Video.all
  end

  def show
    @vidya = Video.find(params[:id])
  end

  def new
    if params.has_key?(:error)
      @errorzy = params[:error]
      @bad_url = params[:bad_url]
    end
  end

  def create
    @URL = valid_url params[:video_data][:url]
    if not @URL then
      redirect_to :controller=>"videos", :action => "new", :error=>"Invalid URL", :bad_url => params[:video_data][:url]
    else
      @vidya = Video.new :name=>params[:video_data][:name], url:@URL
      @vidya.save
      redirect_to @vidya
    end
  end

  def destroy
    @vidya = Video.find(params[:id])
    @vidya.destroy
    redirect_to videos_path
  end

end
