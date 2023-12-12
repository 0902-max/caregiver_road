class User < ApplicationRecord
  has_many :user_past_exam_attempts
  has_many :vocabulary_notes
  has_many :vocabulary_entries
  has_many :events, dependent: :destroy
  has_many :notifications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
