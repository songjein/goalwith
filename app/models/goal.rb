class Goal < ApplicationRecord
	has_many :complete_goals, dependent: :destroy
  belongs_to :user

	acts_as_taggable_on :labels
end
