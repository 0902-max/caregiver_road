class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :choice
  belongs_to :user
end
