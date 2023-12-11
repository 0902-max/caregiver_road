class UserPastExamAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :past_exam
end
