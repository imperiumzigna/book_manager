Rails.application.routes.draw do
  devise_for :admins, path: "auth", path_names: { sign_in: "login", sign_out: "logout",
    sign_up: "register" }, controllers: {
      sessions: "admins/sessions",
      registrations: "admins/registrations"
    }
  resources :books

  root to: "books#index"
end
