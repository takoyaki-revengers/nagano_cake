Rails.application.routes.draw do
  namespace :admin do
    get 'order_details/update'
  end
  namespace :admin do
    get 'orders/show'
    get 'orders/update'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/create'
    get 'genres/edit'
    get 'genres/update'
  end
  namespace :admin do
    get 'items/index'
  end
  namespace :admin do
    get 'homes/top'
  end
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



end
