class CreatePastExams < ActiveRecord::Migration[7.0]
  def change
    create_table :past_exams do |t|
      t.text :exam_text
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :option_e
      t.string :correct_option
      t.text :explanation
      t.integer :exam_year
      t.string :exam_category

      t.timestamps
    end
  end
end
