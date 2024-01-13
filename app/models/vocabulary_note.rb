class VocabularyNote < ApplicationRecord
  belongs_to :user
  has_many :vocabulary_entries

  validates :title, presence: true, length: {maximum: 20}
  validates :description, presence: true
end
