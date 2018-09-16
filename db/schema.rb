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

ActiveRecord::Schema.define(version: 20180915012247) do

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_subscription_id", default: ""
    t.string   "current_id",             default: ""
    t.integer  "membership_type",        default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["stripe_subscription_id"], name: "index_memberships_on_stripe_subscription_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_publishable_key"
    t.string   "stripe_secret_key"
    t.string   "stripe_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "currency"
    t.string   "country"
    t.integer  "month"
    t.integer  "day"
    t.integer  "year"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_merchants_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "plan_id"
    t.string   "product_id"
    t.decimal  "amount",     precision: 10, scale: 2
    t.string   "currency"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "display_name"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "image_data"
    t.string   "age",              default: ""
    t.string   "city",             default: ""
    t.string   "state",            default: ""
    t.string   "country",          default: ""
    t.string   "website",          default: ""
    t.string   "twitter_handle",   default: ""
    t.string   "twitter_url",      default: ""
    t.string   "instagram_handle", default: ""
    t.string   "instagram_url",    default: ""
    t.string   "snapchat_handle",  default: ""
    t.string   "snapchat_url",     default: ""
    t.text     "biography",        default: ""
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subscriber_id"
    t.integer  "subscribed_id"
    t.string   "stripe_subscription_id"
    t.decimal  "amount",                 precision: 10, scale: 2
    t.string   "currency"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["subscribed_id"], name: "index_subscriptions_on_subscribed_id"
    t.index ["subscriber_id", "subscribed_id"], name: "index_subscriptions_on_subscriber_id_and_subscribed_id", unique: true
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               default: "",   null: false
    t.string   "slug",                   default: "",   null: false
    t.boolean  "purchase_email",         default: true
    t.boolean  "refund_email",           default: true
    t.boolean  "subscription_email",     default: true
    t.boolean  "review_email",           default: true
    t.boolean  "comment_email",          default: true
    t.boolean  "message_email",          default: true
    t.string   "customer_id",            default: ""
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.string   "title"
    t.text     "video_data"
    t.text     "image_data"
    t.text     "description"
    t.integer  "policy_type",    default: 0
    t.string   "slug"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["category_id"], name: "index_videos_on_category_id"
    t.index ["subcategory_id"], name: "index_videos_on_subcategory_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

end
