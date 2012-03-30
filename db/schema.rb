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

ActiveRecord::Schema.define(:version => 20120330175616) do

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
  end

  add_index "submissions", ["created_at"], :name => "index_submissions_on_created_at"
  add_index "submissions", ["start_datetime"], :name => "index_submissions_on_start_datetime"
  add_index "submissions", ["status_id"], :name => "index_submissions_on_status_id"
  add_index "submissions", ["updated_at"], :name => "index_submissions_on_updated_at"

end
