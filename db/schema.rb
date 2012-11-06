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

ActiveRecord::Schema.define(:version => 20121102031356) do

  create_table "lines", :force => true do |t|
    t.string "name"
  end

  add_index "lines", ["name"], :name => "index_lines_on_name", :unique => true

  create_table "locations", :force => true do |t|
    t.string "name"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name", :unique => true

  create_table "stops", :force => true do |t|
    t.integer "line_id"
    t.integer "location_id"
    t.string  "time"
    t.string  "days"
  end

  add_index "stops", ["line_id"], :name => "index_stops_on_line_id"
  add_index "stops", ["location_id"], :name => "index_stops_on_location_id"

end
