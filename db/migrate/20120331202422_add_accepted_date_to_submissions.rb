class AddAcceptedDateToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :accepted_at, :datetime
    add_index :submissions, [:accepted_at, :status_id]
  end
end
