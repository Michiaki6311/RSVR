ActiveAdmin.register User do
  config.per_page = 15

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

filter :id
filter :name
filter :email
filter :phone_number
filter :created_at

index do
  selectable_column
  column :id do |user|
    link_to user.id, admin_user_path(user)
  end
  column :name
  column :email
  column :phone_number
  column :created_at

  actions
end

  permit_params :name,:email,:phone_number
end
