class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save!
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def update
    if @band.update(band_params)
      redirect_to @band
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
  end

  private
    def band_params
      params.require(:band).permit(:name)
    end
end
