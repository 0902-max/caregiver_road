class VocabularyEntry < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary_note
end
