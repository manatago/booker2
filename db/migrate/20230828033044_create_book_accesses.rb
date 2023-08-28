class CreateBookAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :book_accesses do |t|
      t.references :book,foreign_key: true,null: false
      t.timestamps
    end
  end
end
