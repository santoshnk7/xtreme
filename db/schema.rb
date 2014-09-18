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

ActiveRecord::Schema.define(:version => 20140910113046) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "alerts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "warning_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "alerts", ["user_id"], :name => "index_alerts_on_user_id"
  add_index "alerts", ["warning_id"], :name => "index_alerts_on_warning_id"

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.string  "photo"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
  end

  create_table "categories_events", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  add_index "categories_events", ["category_id"], :name => "index_categories_events_on_category_id"
  add_index "categories_events", ["event_id"], :name => "index_categories_events_on_event_id"

  create_table "categories_places", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "place_id"
  end

  add_index "categories_places", ["category_id"], :name => "index_categories_places_on_category_id"
  add_index "categories_places", ["place_id"], :name => "index_categories_places_on_place_id"

  create_table "class_ratings", :force => true do |t|
    t.integer  "place_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "company_ads", :force => true do |t|
    t.string   "name"
    t.string   "message"
    t.string   "ad_photo"
    t.string   "path"
    t.boolean  "active",     :default => false
    t.date     "ad_start"
    t.date     "ad_end"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "dbinfos", :force => true do |t|
    t.integer  "s_version"
    t.string   "s_desc"
    t.integer  "Min_cversion"
    t.integer  "Max_cversion"
    t.string   "c_desc"
    t.date     "doe"
    t.string   "link_new"
    t.date     "new_version"
    t.string   "feature_desc"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "trial_period"
  end

  create_table "event_connections", :id => false, :force => true do |t|
    t.integer "parent_id", :null => false
    t.integer "child_id",  :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "contact_number"
    t.datetime "Start_date_time"
    t.datetime "end_date_time"
    t.integer  "grace_period"
    t.boolean  "year_round"
    t.text     "event_type"
    t.integer  "user_id"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.string   "status",                                         :default => "Pending"
    t.string   "featured_photo"
    t.datetime "info_updated_at"
    t.datetime "attrs_updated_at"
    t.string   "contact_photo"
    t.string   "contact_detail"
    t.string   "location"
    t.decimal  "rating",           :precision => 3, :scale => 2
  end

  create_table "events_places", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "place_id"
  end

  add_index "events_places", ["event_id"], :name => "index_events_places_on_event_id"
  add_index "events_places", ["place_id"], :name => "index_events_places_on_place_id"

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id"], :name => "index_events_users_on_event_id"
  add_index "events_users", ["user_id"], :name => "index_events_users_on_user_id"

  create_table "info_tips", :force => true do |t|
    t.string   "message"
    t.string   "featured_photo"
    t.integer  "info_type"
    t.integer  "category_id"
    t.integer  "display_time"
    t.boolean  "close"
    t.integer  "show_limit"
    t.boolean  "active",         :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "place_connections", :force => true do |t|
    t.integer "place_id",                  :null => false
    t.integer "place_b_id",                :null => false
    t.integer "rel_type",   :default => 0
  end

  create_table "place_relations", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.string   "relation_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "place_relations", ["child_id"], :name => "index_place_relations_on_child_id"
  add_index "place_relations", ["parent_id"], :name => "index_place_relations_on_parent_id"

  create_table "places", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "approx_latitude"
    t.string   "approx_longitude"
    t.string   "actual_latitude"
    t.string   "actual_longitude"
    t.integer  "user_id"
    t.string   "status",                                         :default => "Pending"
    t.string   "featured_photo"
    t.datetime "info_updated_at"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.decimal  "rating",           :precision => 3, :scale => 2, :default => 0.0
    t.string   "contact_photo"
    t.string   "contact_detail"
    t.string   "location"
    t.datetime "attrs_updated_at"
    t.integer  "cleanliness"
    t.integer  "p_type"
    t.integer  "star_rating"
    t.integer  "rest_type",                                      :default => 3
  end

  create_table "places_events", :id => false, :force => true do |t|
    t.integer "place_id"
    t.integer "event_id"
  end

  add_index "places_events", ["event_id"], :name => "index_places_events_on_event_id"
  add_index "places_events", ["place_id"], :name => "index_places_events_on_place_id"

  create_table "places_users", :id => false, :force => true do |t|
    t.integer "place_id"
    t.integer "user_id"
  end

  add_index "places_users", ["place_id"], :name => "index_places_users_on_place_id"
  add_index "places_users", ["user_id"], :name => "index_places_users_on_user_id"

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.decimal  "value",      :precision => 3, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "ratings", ["place_id"], :name => "index_ratings_on_place_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "reviews", :force => true do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.text     "message"
    t.string   "status",     :default => "Pending"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "reviews", ["place_id"], :name => "index_reviews_on_place_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "tips", :force => true do |t|
    t.integer  "place_id"
    t.integer  "event_id"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tips", ["place_id"], :name => "index_tips_on_place_id"

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mobile_no"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "country"
    t.datetime "db_updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "warnings", :force => true do |t|
    t.integer  "place_id"
    t.integer  "event_id"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "warnings", ["place_id"], :name => "index_warnings_on_place_id"

end
