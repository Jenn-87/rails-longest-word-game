Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'games#new'
  get 'new', to: 'games#new', as: :games
  get 'score', to: 'games#score'
  get "result", to: "games#score"
end
