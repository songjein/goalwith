Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root "session#new"

	resources :users
	
	get "/login" => "session#new"
	post "/login" => "session#create"
	get "/logout" => "session#destroy"
end
