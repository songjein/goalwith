class GoalsController < ApplicationController

	# 로그인 필요
	def new
		@goal = Goal.new
	end

	# 로그인 필요
	def create
		@goal = Goal.new(goal_params)
		@goal.from = @goal.from + 9.hours
		@goal.to = @goal.to + 9.hours
		@goal.isExpired = false
		@goal.user_id = current_user.id
		if @goal.save
			flash[:notice] = "목표 생성 완료"
			redirect_to current_user
		else
			render "new"
		end
	end


	def complete_form
		@goal = Goal.find(params[:id])	
		@log = Log.new
		render "complete_form"
	end

private
	def goal_params
		params.require(:goal).permit(:body, :from, :to, :color, :weight, :counts, :label_list)
	end
end
