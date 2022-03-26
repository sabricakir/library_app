# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_03_26_154621) do
  create_table "authors", force: :cascade do |t|
    t.text "name"
    t.integer "age"
    t.text "birthPlace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_types", force: :cascade do |t|
    t.text "typeName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.text "name"
    t.integer "page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.integer "publisher_id"
    t.integer "book_type_id"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["book_type_id"], name: "index_books_on_book_type_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "book_types"
  add_foreign_key "books", "publishers"
end
