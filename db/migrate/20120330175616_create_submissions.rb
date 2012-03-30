class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title, :default => '', :null => false
      t.datetime :start_datetime, :null => false
      t.datetime :end_datetime, :null => false
      t.boolean :all_day, :null => false, :default => false
      t.text :where, :defualt => ''
      t.text :description, :default => ''
      t.integer :status_id, :default => 1, :null => false
      t.timestamps
    end
    add_index :submissions, :start_datetime
    add_index :submissions, :status_id
    add_index :submissions, :updated_at
    add_index :submissions, :created_at
  end
end
