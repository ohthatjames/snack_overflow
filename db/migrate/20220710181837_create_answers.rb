class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :question_id
      t.integer :author_id

      t.timestamps

      t.index :created_at
    end
  end
end
