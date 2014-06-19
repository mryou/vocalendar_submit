class AddToSubmissions < ActiveRecord::Migration
  def change


    add_column :submissions, :sponsor_address, :String
    add_column :submissions, :contact_address, :String
    add_column :submissions, :result, :text


  end

end
