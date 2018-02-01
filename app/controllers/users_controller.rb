class UsersController < ApplicationController
	require 'digest/sha1'

	# 최소 몇번의 counts 정보가 있기 때문에 수정해야함
	# 하루에 1번만 달성할 수 있도로 하는 것은 좋은 제약인듯
	def show
		@goals = []
		@goals_completed_today = []
		current_user.goals.where(isExpired: false).each do |g|
			# 한국이라 9시간 더해줌
			today = (Time.now + 9.hours).strftime("%Y-%m-%d")

			# 목표의 달성 목록 중, 오늘 달성한게 있다면 제외하기 위한 플래그
			already_done_today = false
			g.complete_goals.each do |cg|
				if cg.created_at.to_date == today.to_date	
					already_done_today = true
					@goals_completed_today << g
					break
				end
			end

			# 오늘 달성이 안됐으면서, 목표의 to 날짜가 오늘 이후(포함)인 것들 만을 보여준다
			if not already_done_today and g.to >= today
				@goals << g
			# 만약 목표가 만료되었다면 (어제까지) 여기서 처리
			elsif g.to < today 
				g.isExpired = true
				g.save
			end
		end
	end

	# TODO: 계산 효율 계선 
	def statistics
		@pie= {}
		@calendar = {}
		current_user.logs.each do |l|
			# 파이차트 정보
			l.complete_goal.goal.labels.each do |l|
				tag = l.name
				if @pie.key? tag
					@pie[tag] += 1
				else
					@pie[tag] = 1
				end
			end

			# 캘린더 정보
			year = l.created_at.year
			month= l.created_at.month
			day = l.created_at.day
			key = "#{year}/#{month}/#{day}"
			if @calendar.key? key
				@calendar[key] += 1
			else 
				@calendar[key] = 1
			end
		end
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
