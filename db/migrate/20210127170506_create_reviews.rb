class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :score
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
