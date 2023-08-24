class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, :null => false
      t.text :body, :null => false, :limit => 200
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
