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

ActiveRecord::Schema.define(version: 20160207213137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "studentcourses", force: :cascade do |t|
    t.integer  "course1year"
    t.string   "course1sem"
    t.integer  "course2year"
    t.string   "course2sem"
    t.integer  "student_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "course1_file_name"
    t.string   "course1_content_type"
    t.integer  "course1_file_size"
    t.datetime "course1_updated_at"
    t.string   "course2_file_name"
    t.string   "course2_content_type"
    t.integer  "course2_file_size"
    t.datetime "course2_updated_at"
    t.string   "teachexp_file_name"
    t.string   "teachexp_content_type"
    t.integer  "teachexp_file_size"
    t.datetime "teachexp_updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.integer  "unmid"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "issued"
  end

  create_table "studentworkshops", force: :cascade do |t|
    t.integer  "y1"
    t.string   "s1"
    t.string   "n1"
    t.integer  "y2"
    t.string   "s2"
    t.string   "n2"
    t.integer  "y3"
    t.string   "s3"
    t.string   "n3"
    t.integer  "y4"
    t.string   "s4"
    t.string   "n4"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.integer  "year"
    t.string   "semester"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workshops_students", force: :cascade do |t|
    t.integer  "workshop_id"
    t.integer  "unmid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
