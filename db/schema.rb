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

ActiveRecord::Schema.define(:version => 20131008182052) do

  create_table "companies", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "industry",    :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "educations", :force => true do |t|
    t.integer  "owner_id",                           :null => false
    t.string   "school",          :default => ""
    t.integer  "school_id",       :default => 0
    t.string   "city"
    t.string   "state"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current_student", :default => false
    t.string   "area"
    t.string   "degree"
    t.text     "awards"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "educations", ["owner_id"], :name => "index_educations_on_owner_id"

  create_table "friendships", :force => true do |t|
    t.integer  "friender_id",                    :null => false
    t.integer  "friendee_id",                    :null => false
    t.text     "message",                        :null => false
    t.string   "connection_type",                :null => false
    t.integer  "status",          :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "friendships", ["friendee_id"], :name => "index_friendships_on_friendee_id"
  add_index "friendships", ["friender_id"], :name => "index_friendships_on_friender_id"

  create_table "links", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "title"
    t.string   "url",        :null => false
    t.string   "type",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "links", ["owner_id"], :name => "index_links_on_owner_id"

  create_table "phone_numbers", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "number",     :null => false
    t.string   "type",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "phone_numbers", ["owner_id"], :name => "index_phone_numbers_on_owner_id"

  create_table "positions", :force => true do |t|
    t.integer  "owner_id",                            :null => false
    t.string   "title",                               :null => false
    t.string   "company",          :default => ""
    t.integer  "company_id",       :default => 0
    t.string   "industry"
    t.string   "city"
    t.string   "state"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current_position", :default => false
    t.text     "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "positions", ["owner_id"], :name => "index_positions_on_owner_id"

  create_table "users", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "email",                          :null => false
    t.string   "password_digest",                :null => false
    t.string   "session_token",                  :null => false
    t.string   "tagline"
    t.text     "summary"
    t.string   "city"
    t.string   "state"
    t.string   "industry"
    t.integer  "status",          :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["session_token"], :name => "index_users_on_session_token"

end
