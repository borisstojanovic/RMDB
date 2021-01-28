class CreateHelpfuls < ActiveRecord::Migration[6.1]
  def change
    create_table :helpfuls do |t|
      t.references :review, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.string :is_helpful, default: "helpful"

      t.timestamps
    end
  end
end
