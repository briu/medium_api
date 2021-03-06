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

ActiveRecord::Schema.define(version: 20171009114814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ips", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "avg_rate"
    t.integer  "lock_version"
    t.integer  "rates_sum",    default: 0
    t.integer  "rates_count",  default: 0
    t.index ["avg_rate"], name: "index_posts_on_avg_rate", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "posts_ips", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "ip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "ip_id"], name: "index_posts_ips_on_post_id_and_ip_id", using: :btree
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "value"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_rates_on_post_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_ips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_id", "user_id"], name: "index_users_ips_on_ip_id_and_user_id", unique: true, using: :btree
  end

end
