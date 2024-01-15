class PastExam < ApplicationRecord
  has_many :user_past_exam_attempts

  def random_next_exam_id
    PastExam.where.not(id: id).pluck(:id).sample
  end
  #def next_exam(current_exam)
    #self.class.where("id > ?", current_exam.id).order("id ASC").first
  #end
end
