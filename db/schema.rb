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

ActiveRecord::Schema.define(version: 20150627014109) do

  create_table "episodes", force: true do |t|
    t.string   "name",                         null: false
    t.integer  "season",                       null: false
    t.integer  "ep_in_season",                 null: false
    t.string   "link",                         null: false
    t.integer  "show_id",                      null: false
    t.boolean  "downloaded",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "name",       null: false
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.string   "regex"
    t.integer  "show_id",    null: false
    t.integer  "feed_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords"
    t.string   "quality"
  end

  create_table "settings", force: true do |t|
    t.string  "key",  null: false
    t.string  "str"
    t.integer "int"
    t.boolean "bool"
  end

  create_table "shows", force: true do |t|
    t.string   "name",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster"
    t.string   "overview"
    t.string   "actors"
    t.date     "first_aired"
    t.string   "rating"
    t.string   "status"
    t.string   "airs_dayofweek"
    t.string   "airs_time"
    t.string   "genre"
    t.integer  "tvdb_id"
  end

end
