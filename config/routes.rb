#                Prefix Verb   URI Pattern                           Controller#Action
#                 users POST   /users(.:format)                      users#create
#              new_user GET    /users/new(.:format)                  users#new
#         user_sessions POST   /user_sessions(.:format)              user_sessions#create
#          user_session DELETE /user_sessions/:id(.:format)          user_sessions#destroy
#              sign_out DELETE /sign_out(.:format)                   user_sessions#destroy
#               sign_in GET    /sign_in(.:format)                    user_sessions#new
#     yandex_translates GET    /yandex_translates(.:format)          yandex_translates#index
#                       POST   /yandex_translates(.:format)          yandex_translates#create
#  new_yandex_translate GET    /yandex_translates/new(.:format)      yandex_translates#new
# edit_yandex_translate GET    /yandex_translates/:id/edit(.:format) yandex_translates#edit
#      yandex_translate GET    /yandex_translates/:id(.:format)      yandex_translates#show
#                       PATCH  /yandex_translates/:id(.:format)      yandex_translates#update
#                       PUT    /yandex_translates/:id(.:format)      yandex_translates#update
#                       DELETE /yandex_translates/:id(.:format)      yandex_translates#destroy
#                  root GET    /                                     welcome#index


Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in

  resources :yandex_translates
  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
