class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.references :speaker, foreign_key: { to_table: :users }, null: false
      t.references :target, foreign_key: { to_table: :users }, null: false
      t.string :message
      t.timestamps
    end
  end
end
