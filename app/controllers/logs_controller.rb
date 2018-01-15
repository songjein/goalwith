class LogsController < ApplicationController

	# 로그인 필요 + 자기 소유
	def create
		@goal = Goal.find(params[:log][:goal_id])
		if @goal.user.id != current_user.id
			flash[:notice] = "자신의 소유가 아닙니다"
			redirect_to current_user 
		end

		@log = Log.new(log_params)
		@log.user_id = current_user.id

		if @log.save
			complete_goal = CompleteGoal.new
			complete_goal.goal_id = @goal.id
			complete_goal.log_id = @log.id
			complete_goal.save
			flash[:notice] = "목표 달성 완료"
			redirect_to current_user 
		else 
			# pass		
		end
	end

private
	def log_params
		params.require(:log).permit(:body)
	end
end
