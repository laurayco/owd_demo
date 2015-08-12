class VideosController < ApplicationController
  def new
  end

  def create
    render plain: params[:videos][:name]
  end

  def index
  end
end
