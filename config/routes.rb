Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup', to: 'users#new'   # get 'users/new' （←$ rails generate controller Users newで自動作成されたの）を左記に変更
  resources :users  # ユーザーのURLを生成するための多数の名前付きルートと共に、RESTfulなUsersリソースで必要となる全てのアクションが利用できるようになります。
end