Rails.application.routes.draw do
  devise_for :students
  devise_for :teachers
  resources :courses do
    resources :posts do
      resources :comments
    end
  end
  post "courses/join"

  get "students/check_signed_in"
  post "students/api_sign_in"
  delete "students/api_sign_out"

  get "teachers/check_signed_in"
  post "teachers/api_sign_in"
  delete "teachers/api_sign_out"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
