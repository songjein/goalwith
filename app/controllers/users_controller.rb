class UsersController < ApplicationController
	require 'digest/sha1'

	def show
	end

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)	
		@user.salt = BCrypt::Engine.generate_salt
		@user.password = BCrypt::Engine.hash_secret(params[:user][:password], @user.salt)
		@user.password_confirmation = BCrypt::Engine.hash_secret(params[:user][:password_confirmation], @user.salt)
		
		if @user.save
			flash[:notice] = "회원가입 완료"	
			redirect_to "/login"
		else
			render "new"
		end
	end

	def edit
	end

	def update
	end

private
	def user_params
		params.require(:user).permit(:user_id, :nick, :password, :password_confirmation)
	end
end
