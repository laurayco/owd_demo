class WelcomeController < ApplicationController
  def index
    @vidyas = Video.order(:created_at).limit(5)
  end
end
