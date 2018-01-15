class Goal < ApplicationRecord
  belongs_to :user

	acts_as_taggable_on :labels
end
