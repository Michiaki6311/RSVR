ActiveAdmin.register Reservation do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
actions :all,except: [:edit,:update]

index do
  selectable_column
  column :id do |reservation|
    link_to reservation.id,admin_reservation_path(reservation)
  end
  column :strat_time
  column :end_time
  column :user
  column :facility

  actions
end

end
