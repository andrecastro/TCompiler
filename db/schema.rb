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

ActiveRecord::Schema.define(:version => 20111020001952) do

  create_table "automata", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfa_automata", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sintactic_tables", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symbol_tables", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_regexes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tlexes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokenizers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "txt_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_inputs", :force => true do |t|
    t.string   "regular_expression"
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
