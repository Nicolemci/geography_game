Rails.application.routes.draw do
  root 'home#index'

  get 'games/population', to: 'game#population'
  post 'games/population/check_order', to: 'game#check_population_order', as: 'check_population_order'

  get 'games/area', to: 'game#area'
  post 'games/area/check_order', to: 'game#check_area_order', as: 'check_area_order'

  get 'games/capital', to: 'game#capital'
  post 'games/capital/check_order', to: 'game#check_capital_order', as: 'check_capital_order'

  # Add more routes for additional games as needed
end
