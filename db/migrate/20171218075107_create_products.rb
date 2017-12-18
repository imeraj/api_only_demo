class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.boolean :published
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
    add_index :products, :user_id
  end
end
