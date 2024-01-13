class VocabularyEntry < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary_note

  validates :word, presence: true, length: { maximum: 20 }
  validates :meaning, presence: true
end