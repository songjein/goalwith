class GoalsController < ApplicationController
	def new
		@goal = Goal.new
	end

	def create
		@goal = Goal.new(goal_params)
		@goal.from = @goal.from + 9.hours
		@goal.to = @goal.to + 9.hours
		@goal.isCompleted = false
		@goal.user_id = current_user.id
		if @goal.save
			flash[:notice] = "목표 생성 완료"
			redirect_to current_user
		else
			render "new"
		end
	end

private
	def goal_params
		params.require(:goal).permit(:body, :from, :to, :color, :weight, :counts, :label_list)
	end
end
