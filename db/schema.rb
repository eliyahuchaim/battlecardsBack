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

ActiveRecord::Schema.define(version: 20170830193504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_cards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "class_type_id"
    t.integer "kills"
    t.integer "score"
    t.integer "time_played"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_types", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "bf1_username"
    t.integer "platform"
    t.string "rank"
    t.integer "kills"
    t.integer "deaths"
    t.integer "spm"
    t.integer "kpm"
    t.integer "skill"
    t.integer "wins"
    t.integer "losses"
    t.integer "award_score"
    t.integer "avenged_deaths"
    t.integer "accuracy_ratio"
    t.integer "flags_captured"
    t.integer "flags_defended"
    t.integer "head_shots"
    t.integer "dogtags_taken"
    t.string "best_class"
    t.integer "highest_kill_streak"
    t.integer "kdr"
    t.integer "revives"
    t.integer "longest_headshot"
    t.integer "heals"
    t.integer "savior_kills"
    t.integer "squad_score"
    t.integer "games_played"
    t.integer "repairs"
    t.integer "kill_assists"
    t.integer "suppression_assists"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_card_types", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_cards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "vehicle_card_type_id"
    t.integer "kills"
    t.integer "time_played"
    t.integer "amount_of_vehicles_destroyed"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapon_card_types", force: :cascade do |t|
    t.string "guid"
    t.string "name"
    t.string "image"
    t.string "description"
    t.string "category"
    t.integer "ammo_cap"
    t.string "ammo_type"
    t.integer "rate_of_fire"
    t.string "range"
    t.integer "number_of_magazines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapon_cards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "weapon_card_type_id"
    t.integer "kills"
    t.integer "headshots"
    t.integer "accuracy"
    t.integer "time_played"
    t.integer "hits"
    t.integer "shots"
    t.boolean "unlocked"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
