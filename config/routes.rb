Rails.application.routes.draw do


  # devise_for :admins
  # devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html




#   # 顧客用
# # URL /customers/sign_in ...
# devise_for :customers, controllers: {
#   registrations: "public/registrations",
#   sessions: 'public/sessions'
# }

# # 管理者用
# # URL /admin/sign_in ...
# devise_for :admin, controllers: {
#   sessions: "admin/sessions"
# }


# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
  end


# ここから↓↓

  scope module: "public" do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get  "/customers/sign_out" => "sessions#destroy"

    get "/customers/my_page" => "customers#show" #会員情報詳細ページ（マイページ）表示
    get "/customers/unsubscribe" => "customers#unsubscribe" #退会確認画面の表示
    patch "/customers/withdraw" => "customers#withdraw" #退会フラグを切り替える


    resources :items, only: [:index,:show]
    resources :customers, only: [:edit,:update]
    resources :cart_items, only: [:index,:update,:destroy,:create]
    resources :orders, only: [:index,:show,:new,:create,]
    post "/orders/confirm" => "orders#confirm" #注文情報確認画面を表示する
    get "/orders/thanks" => "orders#thanks" #注文完了画面を表示する
    resources :addresses, only: [:index,:create,:destroy,:edit,:update]
    resources :genres, only: [:show]

  end
# ここまで↑↑ 会員


end
