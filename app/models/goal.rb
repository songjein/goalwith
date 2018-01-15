class Goal < ApplicationRecord
	has_many :complete_goals
  belongs_to :user

	acts_as_taggable_on :labels
end
