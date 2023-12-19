class AddPastScoreToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :past_score, :integer, default: 0
  end
end
