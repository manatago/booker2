class CreateFavorites < ActiveRecord::Migration[6.1]
 
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false
      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end

end
