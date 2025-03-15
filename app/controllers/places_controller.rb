class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @places = Place.where(user_id: session[:user_id]) # Only show user's places
  end

  def show
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])
    if @place.nil?
      redirect_to places_path, alert: "Not authorized to view this place."
    end
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = session[:user_id] # Assign current user

    if @place.save
      redirect_to places_path, notice: "Place successfully created!"
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :description)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end