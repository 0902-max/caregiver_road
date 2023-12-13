class Question < ApplicationRecord
  has_many :choices
  has_many :answers
  has_many :documents
end
