class CreateGrants < ActiveRecord::Migration[7.0]
  def change
    create_table :grants do |t|
      t.string :subsidy_name
      t.text :purpose
      t.string :industry
      t.integer :employees_count
      t.string :target_region
      t.datetime :start_date
      t.datetime :end_date
      t.text :summary
      t.string :catch_phrase
      t.integer :max_grant_amount
      t.text :target_region_details

      t.timestamps
    end
  end
end
