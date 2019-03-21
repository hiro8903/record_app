Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup', to: 'users#new'   # get 'users/new' （←$ rails generate controller Users newで自動作成されたの）を左記に変更
end