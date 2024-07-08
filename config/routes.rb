Rails.application.routes.draw do
  root 'game#index'
  post 'check_order', to: 'game#check_order'
end
