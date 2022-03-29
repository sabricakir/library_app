Rails.application.routes.draw do
  root "books#index"
  resources :books, :authors, :publishers, :book_types

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
