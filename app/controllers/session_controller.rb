class SessionController < ApplicationController
	require 'digest/sha1'

	def new
		if current_user
			redirect_to current_user 
		else
			render "session/new"
		end
	end

	def create
		@user = User.find_by(user_id: params[:session][:user_id])

		if @user 
			pw = BCrypt::Engine.hash_secret(params[:session][:password], @user.salt)
			if @user.password == pw 
				session[:user_id] = @user.id					
				redirect_to @user 
			else
				flash[:notice] = "아이디 혹은 비밀번호가 잘못되었습니다"
				render "new"
			end
		else 
			flash[:notice] = "아이디 혹은 비밀번호가 잘못되었습니다"
			render "new"
		end
	end


	def destroy
		if current_user
			session.delete(:user_id)
			flash[:notice] = "이용해주셔서 감사합니다;D"
		end
		redirect_to login_path
	end

private
	def post_params
		params.require(:session).permit(:user_id, :password)
	end

end
