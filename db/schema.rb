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

ActiveRecord::Schema.define(:version => 20131014223734) do

  create_table "companies", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "industry",         :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "summary"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "name"
    t.string   "value",        :null => false
    t.integer  "contact_type", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "deliveries", :force => true do |t|
    t.integer  "message_id", :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "deliveries", ["message_id"], :name => "index_deliveries_on_message_id"
  add_index "deliveries", ["user_id"], :name => "index_deliveries_on_user_id"

  create_table "experiences", :force => true do |t|
    t.integer  "owner_id",                      :null => false
    t.string   "name",       :default => ""
    t.string   "city"
    t.string   "state"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current",    :default => false
    t.string   "string_1"
    t.string   "string_2"
    t.text     "body"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "position",   :default => false
  end

  add_index "experiences", ["owner_id"], :name => "index_experiences_on_owner_id"

  create_table "friendships", :force => true do |t|
    t.integer  "friender_id",                    :null => false
    t.integer  "friendee_id",                    :null => false
    t.text     "message",                        :null => false
    t.string   "connection_type",                :null => false
    t.integer  "status",          :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "token"
  end

  add_index "friendships", ["friendee_id"], :name => "index_friendships_on_friendee_id"
  add_index "friendships", ["friender_id"], :name => "index_friendships_on_friender_id"
  add_index "friendships", ["token"], :name => "index_friendships_on_token"

  create_table "links", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "title"
    t.string   "url",        :null => false
    t.string   "type",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "links", ["owner_id"], :name => "index_links_on_owner_id"

  create_table "memberships", :force => true do |t|
    t.integer  "company_id",                :null => false
    t.integer  "member_id",                 :null => false
    t.integer  "status",     :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "memberships", ["company_id"], :name => "index_memberships_on_company_id"
  add_index "memberships", ["member_id"], :name => "index_memberships_on_member_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "subject",    :default => "(no subject)"
    t.text     "body",                                   :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "unread",     :default => true
  end

  add_index "messages", ["company_id"], :name => "index_messages_on_company_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

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

  create_table "responses", :force => true do |t|
    t.integer  "status_id",  :null => false
    t.integer  "user_id",    :null => false
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "responses", ["status_id"], :name => "index_responses_on_status_id"
  add_index "responses", ["user_id"], :name => "index_responses_on_user_id"

  create_table "statuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.text     "body"
    t.string   "link"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "statuses", ["company_id"], :name => "index_statuses_on_company_id"
  add_index "statuses", ["user_id"], :name => "index_statuses_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",                      :null => false
    t.string   "last_name",                       :null => false
    t.string   "email",                           :null => false
    t.string   "password_digest",                 :null => false
    t.string   "session_token",                   :null => false
    t.string   "tagline"
    t.text     "summary"
    t.string   "city"
    t.string   "state"
    t.string   "industry"
    t.integer  "status",           :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["session_token"], :name => "index_users_on_session_token"

end
