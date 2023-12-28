class User < ApplicationRecord
  has_many :documents
  has_many :answers
  has_many :events
  has_many :user_past_exam_attempts
  has_many :vocabulary_notes
  has_many :vocabulary_entries
  has_many :events, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def incorrect_attempts
    user_past_exam_attempts.where(is_correct: false)
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
