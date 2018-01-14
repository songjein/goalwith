class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private
	def current_user
		# find로 할 경우 못찾으면 에러가남
		@current_user ||= User.find_by(id:session[:user_id])
	end
	helper_method :current_user
end
