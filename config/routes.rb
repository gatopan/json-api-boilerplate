Rails.application.routes.draw do
  post 'login', to: 'people#login'
  get 'secret', to: 'people#secret'

  resources :people, except: [:new, :edit]
end
