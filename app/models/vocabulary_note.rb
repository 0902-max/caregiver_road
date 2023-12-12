class VocabularyNote < ApplicationRecord
  belongs_to :user
  has_many :vocabulary_entries
end
