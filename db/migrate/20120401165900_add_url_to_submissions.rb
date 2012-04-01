class AddUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :url, :text
  end
end
