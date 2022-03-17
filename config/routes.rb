Rails.application.routes.draw do
  namespace :public do
    get 'address/index'
    get 'address/edit'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'oders/new'
    get 'oders/thanks'
    get 'oders/index'
    get 'oders/show'
  end
  namespace :public do
    get 'car_items/index'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
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
