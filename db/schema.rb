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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141208035325) do

  create_table "notification_types", force: true do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notifications", force: true do |t|
    t.integer  "receiver_id",                          null: false
    t.integer  "sender_id",                            null: false
    t.integer  "notification_type_id",                 null: false
    t.integer  "arg_id",                               null: false
    t.boolean  "notified",             default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "notifications", ["notification_type_id"], name: "index_notifications_on_notification_type_id"
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id"
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id"

  create_table "skill_levels", force: true do |t|
    t.string   "skill_level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "ntrp_rating"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "court_address"
    t.string   "right_left_handed"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_digest"
    t.integer  "skill_level_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["skill_level_id"], name: "index_users_on_skill_level_id"

end
