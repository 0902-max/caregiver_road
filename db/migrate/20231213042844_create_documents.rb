class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true
      t.string :document_name

      t.timestamps
    end
  end
end
