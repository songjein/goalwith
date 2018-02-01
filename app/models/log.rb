class Log < ApplicationRecord
  belongs_to :user
	has_one :complete_goal
end
