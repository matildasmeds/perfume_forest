Rails.application.routes.draw do

  root 'perfumes#index'
  resources :perfumes, only: [:index, :show]
  resources :notes, only: [:index, :show]
  resources :similarity_scores, only: [:show]
end
