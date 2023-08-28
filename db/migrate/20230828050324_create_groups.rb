class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :introduction
      t.references :owner,foreign_key: { to_table: :users },null: false
      t.timestamps
    end
  end
end
