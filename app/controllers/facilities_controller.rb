class FacilitiesController < ApplicationController
  def show
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      flash[:notice] = "施設を追加しました。"
      redirect_to root_path
    else
      flash[:alert] = "施設の登録に失敗しました。"
      redirect_to root_path
    end
  end

    private
    def facility_params
      params.require(:facility).permit(:id,:name)
    end
end
