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

ActiveRecord::Schema.define(:version => 20110323080303) do

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id"], :name => "index_memberships_on_project_id"
  add_index "memberships", ["user_id", "project_id"], :name => "index_memberships_on_user_id_and_project_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start"
    t.datetime "due"
    t.datetime "finish"
    t.decimal  "budget",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phases", ["name"], :name => "index_phases_on_name"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "budget",      :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name", :unique => true

  create_table "task_assignments", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_assignments", ["task_id", "user_id"], :name => "index_task_assignments_on_task_id_and_user_id", :unique => true
  add_index "task_assignments", ["task_id"], :name => "index_task_assignments_on_task_id"
  add_index "task_assignments", ["user_id"], :name => "index_task_assignments_on_user_id"

  create_table "task_statuses", :force => true do |t|
    t.string "name"
  end

  create_table "task_types", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "cost",           :precision => 8, :scale => 2, :default => 0.0
    t.integer  "project_id"
    t.integer  "phase_id"
    t.integer  "user_id"
    t.integer  "task_type_id"
    t.integer  "task_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["name"], :name => "index_tasks_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
