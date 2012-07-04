class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :group_id, :null => false, :default => 1
      t.integer :order_class, :default => 200, :null => false
      t.boolean :disabled, :default => false, :null => false
      t.timestamps
    end

    add_column :categories, :sub_category_group_id, :integer
    add_column :submissions, :sub_category_id, :integer

    add_index :sub_categories, :group_id
  end
end
