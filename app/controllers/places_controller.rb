class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def edit
    
  end
  
  def show
    @place = Place.find( params[ :id ] )
  end

  def create
    @place = Place.create( place_params ) 
    if @place
      redirect_to places_url
    else 
      render :new
    end
  end

  def destroy
    @place = Place.find( params[ :id ] )
    @place.destroy
    redirect_to places_url
  end

  private

  def place_params
    params.require( :place ).permit( :name, :place )
  end

end
