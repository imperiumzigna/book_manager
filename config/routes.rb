Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: { sign_in: "login", sign_out: "logout",
    sign_up: "register" }, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  resources :books

  root to: "books#index"
end
