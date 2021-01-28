class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors do |t|
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.text :bio, default: ""

      t.timestamps
    end
  end
end
