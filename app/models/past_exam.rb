class PastExam < ApplicationRecord
  has_many :user_past_exam_attempts

  def next_exam(current_exam)
    self.class.where("id > ?", current_exam.id).order("id ASC").first
  end
end
