class AddDisabledToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :disabled, :boolean, :default => false
    remove_index :categories, [:order_class, :id]
    add_index :categories, [:order_class, :name]
  end
end
