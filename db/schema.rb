# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120403101742) do

  create_table "categories", :force => true do |t|
    t.string   "name",                           :null => false
    t.integer  "order_class", :default => 200,   :null => false
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "disabled",    :default => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true
  add_index "categories", ["order_class", "name"], :name => "index_categories_on_order_class_and_name"

  create_table "submissions", :force => true do |t|
    t.string   "title",          :default => "",    :null => false
    t.datetime "start_datetime",                    :null => false
    t.datetime "end_datetime",                      :null => false
    t.boolean  "all_day",        :default => false, :null => false
    t.text     "where"
    t.text     "description",    :default => ""
    t.integer  "status_id",      :default => 1,     :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.datetime "accepted_at"
    t.integer  "category_id"
    t.text     "url"
  end

  add_index "submissions", ["accepted_at", "status_id"], :name => "index_submissions_on_accepted_at_and_status_id"
  add_index "submissions", ["created_at"], :name => "index_submissions_on_created_at"
  add_index "submissions", ["start_datetime"], :name => "index_submissions_on_start_datetime"
  add_index "submissions", ["status_id"], :name => "index_submissions_on_status_id"
  add_index "submissions", ["updated_at"], :name => "index_submissions_on_updated_at"

end
