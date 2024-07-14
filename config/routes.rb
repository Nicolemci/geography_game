Rails.application.routes.draw do
  root 'home#index'

  get 'games/population', to: 'game#population'
  post 'games/population/check_order', to: 'game#check_population_order'

  get 'games/area', to: 'game#area'
  post 'games/area/check_order', to: 'game#check_area_order'

  get 'games/random', to: 'game#random'
  post 'games/random/check_order', to: 'game#check_random_order'
end
