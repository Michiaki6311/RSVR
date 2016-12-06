class FacilitiesController < ApplicationController
  def show
    @facilities = Facility.all
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      flash[:notice] = "施設を追加しました。"
      redirect_to @facility
    else
      flash[:alert] = "施設の登録に失敗しました。"
      redirect_to new_facility_path
    end
  end

  def destroy
    @facility = Facility.find_by(id: params[:id])
    return redirect_to root_url if @facility.nil?
    @facility.destroy
    flash[:notice] = "Facility deleted"
    redirect_to root_url
  end

  private
  def facility_params
    params.require(:facility).permit(:id,:name)
  end
end
