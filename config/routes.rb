Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root "session#new"

	resources :users
	resources :goals
	resources :logs, only: [:create]

	get "/statistics" => "users#statistics"
	
	get "/login" => "session#new"
	post "/login" => "session#create"
	get "/logout" => "session#destroy"

	get "/complete_form/:id" => "goals#complete_form"
end
