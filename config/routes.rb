Rails.application.routes.draw do

  #トップページ
  root to: "tasks#index"

  #ログイン・ログアウト
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  #task　
  resources :tasks
  
  #ユーザー登録
  get "signup" ,to: "users#new"  
  resources :users, only: [:new, :create]
  
  
  
end
