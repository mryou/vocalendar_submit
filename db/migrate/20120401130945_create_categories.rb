class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.integer :order_class, :default => 200, :null => false
      t.text :description
      t.timestamps
    end
    add_index :categories, :name, :unique => true
    add_index :categories, [:order_class, :id]

    add_column :submissions, :category_id, :integer
  end
end
