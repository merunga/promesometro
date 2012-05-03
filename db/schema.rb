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

ActiveRecord::Schema.define(:version => 20120503215143) do

  create_table "admines", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admines", ["authentication_token"], :name => "index_admines_on_authentication_token", :unique => true
  add_index "admines", ["email"], :name => "index_admines_on_email", :unique => true
  add_index "admines", ["reset_password_token"], :name => "index_admines_on_reset_password_token", :unique => true

  create_table "ciudadanos", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "login_type",                                              :null => false
    t.string   "facebook"
    t.string   "twitter"
    t.integer  "info_funcionario_id"
    t.string   "email",                                 :default => "",   :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.boolean  "perfil_publico",                        :default => true, :null => false
  end

  add_index "ciudadanos", ["authentication_token"], :name => "index_ciudadanos_on_authentication_token", :unique => true
  add_index "ciudadanos", ["confirmation_token"], :name => "index_ciudadanos_on_confirmation_token", :unique => true
  add_index "ciudadanos", ["email"], :name => "index_ciudadanos_on_email", :unique => true
  add_index "ciudadanos", ["reset_password_token"], :name => "index_ciudadanos_on_reset_password_token", :unique => true
  add_index "ciudadanos", ["unlock_token"], :name => "index_ciudadanos_on_unlock_token", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "ciudadano_id",     :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["ciudadano_id"], :name => "index_comments_on_ciudadano_id"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"

  create_table "embedes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "hitos", :force => true do |t|
    t.integer  "prueba_id",   :null => false
    t.string   "descripcion", :null => false
    t.boolean  "completado"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "info_funcionarios", :force => true do |t|
    t.string   "nombre",         :null => false
    t.string   "cargo"
    t.string   "entidad"
    t.string   "dni"
    t.string   "telefono"
    t.integer  "promesa_id"
    t.integer  "funcionario_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "promesas", :force => true do |t|
    t.text     "lo_prometido",                         :null => false
    t.date     "fecha_declaracion"
    t.integer  "region_id"
    t.integer  "uploader_id",                          :null => false
    t.date     "fecha_compromiso"
    t.boolean  "denuncia_anonima",  :default => false
    t.text     "slug"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "publica",           :default => true,  :null => false
    t.string   "funcionario_token"
  end

  create_table "pruebas", :force => true do |t|
    t.text     "descripcion",                    :null => false
    t.integer  "uploader_id",                    :null => false
    t.integer  "promesa_id",                     :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "posicion",                       :null => false
    t.boolean  "anonima",     :default => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reclamos", :force => true do |t|
    t.integer  "promesa_id",   :null => false
    t.integer  "ciudadano_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "reclamos", ["ciudadano_id"], :name => "fk_reclamantes"
  add_index "reclamos", ["promesa_id"], :name => "fk_reclamados"

  create_table "recursos", :force => true do |t|
    t.integer  "prueba_id"
    t.string   "type"
    t.string   "link",       :limit => 1000
    t.string   "embed",      :limit => 1000
    t.string   "file"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "regiones", :force => true do |t|
    t.string   "nombre",                                    :null => false
    t.decimal  "long",       :precision => 10, :scale => 0
    t.decimal  "lat",        :precision => 10, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "versiones", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versiones", ["item_type", "item_id"], :name => "index_versiones_on_item_type_and_item_id"

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
