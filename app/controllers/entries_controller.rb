class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place

  def index
    @entries = @place.entries.where(user_id: session[:user_id])
  end

  def show
    @entry = @place.entries.find_by(id: params[:id], user_id: session[:user_id])
    if @entry.nil?
      redirect_to place_entries_path(@place), alert: "Not authorized to view this entry."
    end
  end

  def create
    @entry = @place.entries.new(entry_params)
    @entry.user_id = session[:user_id]

    if @entry.save
      redirect_to place_entries_path(@place), notice: "Entry created successfully!"
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end

  def set_place
    @place = Place.find_by(id: params[:place_id], user_id: session[:user_id])
    if @place.nil?
      redirect_to places_path, alert: "Not authorized."
    end
  end
end