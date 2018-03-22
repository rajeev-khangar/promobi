class HomeController < ApplicationController
  include HomeHelper

  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
end
