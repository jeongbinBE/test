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

ActiveRecord::Schema.define(version: 20150117035747) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rest_keys", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "cat_code"
    t.string   "name"
    t.text     "addr"
    t.boolean  "delivery"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rest_keys", ["addr"], name: "by_addr", length: {"addr"=>255}, using: :btree
  add_index "rest_keys", ["cat_code"], name: "by_cat_code", using: :btree
  add_index "rest_keys", ["delivery"], name: "by_delivery", using: :btree
  add_index "rest_keys", ["name"], name: "by_name", using: :btree
  add_index "rest_keys", ["restaurant_id"], name: "by_restaurant_id", using: :btree

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "cat"
    t.string   "sub_cat"
    t.string   "addr"
    t.string   "phnum"
    t.boolean  "delivery"
    t.integer  "menu_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.integer  "cat_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
