class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # ステータスのenum定義
  enum status: [:unread, :read]
end
