Strobehub::Application.routes.draw do
  resources   :users
  resources   :tracks
  resources   :repositories do
    resources :versions
  end

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'static_pages#login'
  post  '/login'  => 'static_pages#login'
  get   '/logout' => 'static_pages#logout'
  post	'/repositories/:repository_id/versions/:id' => 'versions#update'

end
