class PastExam < ApplicationRecord
  has_many :user_past_exam_attempts

  def random_next_exam_id
    PastExam.where.not(id: id).pluck(:id).sample
  end
end
