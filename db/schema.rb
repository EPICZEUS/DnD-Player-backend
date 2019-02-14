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

ActiveRecord::Schema.define(version: 2019_02_13_145601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_channels", force: :cascade do |t|
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_channels_on_campaign_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public"
    t.integer "selected_encounter"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "campaigns_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.index ["campaign_id"], name: "index_campaigns_users_on_campaign_id"
    t.index ["user_id"], name: "index_campaigns_users_on_user_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.string "name"
    t.string "race"
    t.string "char_class"
    t.integer "level"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "cha"
    t.string "speed"
    t.integer "hp"
    t.string "alignment"
    t.integer "armor_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_characters_on_campaign_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "characters_encounters", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "encounter_id"
    t.index ["character_id"], name: "index_characters_encounters_on_character_id"
    t.index ["encounter_id"], name: "index_characters_encounters_on_encounter_id"
  end

  create_table "creatures", force: :cascade do |t|
    t.string "name"
    t.string "creature_type"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "cha"
    t.integer "challenge_rating"
    t.integer "armor_class"
    t.string "speed"
    t.integer "hp"
    t.string "alignment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
  end

  create_table "creatures_encounters", force: :cascade do |t|
    t.bigint "encounter_id"
    t.bigint "creature_id"
    t.index ["creature_id"], name: "index_creatures_encounters_on_creature_id"
    t.index ["encounter_id"], name: "index_creatures_encounters_on_encounter_id"
  end

  create_table "dm_channels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dm_channels_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dm_channel_id"
    t.index ["dm_channel_id"], name: "index_dm_channels_users_on_dm_channel_id"
    t.index ["user_id"], name: "index_dm_channels_users_on_user_id"
  end

  create_table "encounters", force: :cascade do |t|
    t.bigint "campaign_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_url"
    t.string "name"
    t.index ["campaign_id"], name: "index_encounters_on_campaign_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "channel_type"
    t.bigint "channel_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_type", "channel_id"], name: "index_messages_on_channel_type_and_channel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.bigint "encounter_id"
    t.string "playable_type"
    t.bigint "playable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["encounter_id"], name: "index_positions_on_encounter_id"
    t.index ["playable_type", "playable_id"], name: "index_positions_on_playable_type_and_playable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
  end

  add_foreign_key "campaign_channels", "campaigns"
  add_foreign_key "campaigns", "users"
  add_foreign_key "campaigns_users", "campaigns"
  add_foreign_key "campaigns_users", "users"
  add_foreign_key "characters", "campaigns"
  add_foreign_key "characters", "users"
  add_foreign_key "characters_encounters", "characters"
  add_foreign_key "characters_encounters", "encounters"
  add_foreign_key "creatures_encounters", "creatures"
  add_foreign_key "creatures_encounters", "encounters"
  add_foreign_key "dm_channels_users", "dm_channels"
  add_foreign_key "dm_channels_users", "users"
  add_foreign_key "encounters", "campaigns"
  add_foreign_key "messages", "users"
  add_foreign_key "positions", "encounters"
end
