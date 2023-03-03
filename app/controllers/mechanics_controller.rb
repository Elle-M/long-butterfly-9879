class MechanicsController < ActionController::Base

  def show
    @mechanic = Mechanic.find(params[:id])
  end

  def update
    ride = Ride.find(strong_params[:ride_id])
    ride.create(mechanic_id: params[:id])
    
    redirect_to merchanic_path(params[:id])
  end

  private
  def strong_params
    params.require(:mechanic).permit(:ride_id)
  end
end