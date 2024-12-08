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

ActiveRecord::Schema[8.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "tbcolaboradores", primary_key: "cola_id", id: :serial, force: :cascade do |t|
    t.string "cola_nombre", limit: 100, null: false
    t.string "cola_apelllido", limit: 100, null: false
    t.string "cola_sexo", limit: 1, null: false
    t.string "cola_email", limit: 100, null: false

    t.unique_constraint ["cola_email"], name: "tbcolaboradores_cola_email_key"
  end

  create_table "tbcolaboradores_por_sucursales", primary_key: "cosu_id", id: :serial, force: :cascade do |t|
    t.integer "cola_id"
    t.integer "sucu_id"
    t.decimal "distancia_km", precision: 5, scale: 2, null: false

    t.check_constraint "distancia_km > 0::numeric AND distancia_km <= 50::numeric", name: "tbcolaboradores_por_sucursales_distancia_km_check"
    t.unique_constraint ["cola_id", "sucu_id"], name: "tbcolaboradores_por_sucursales_cola_id_sucu_id_key"
  end

  create_table "tbsucursales", primary_key: "sucu_id", id: :serial, force: :cascade do |t|
    t.string "sucu_nombre", limit: 100, null: false
    t.string "sucu_direccion", limit: 100, null: false
  end

  create_table "tbtransportistas", primary_key: "trans_id", id: :serial, force: :cascade do |t|
    t.string "trans_nombre", limit: 100, null: false
    t.string "trans_apellido", limit: 100, null: false
    t.decimal "tarifa_por_km", precision: 10, scale: 2, null: false
  end

  create_table "tbusers", primary_key: "user_user_id", id: :serial, force: :cascade do |t|
    t.string "user_username", limit: 50, null: false
    t.text "user_password_hash", null: false
    t.string "role", limit: 20, null: false

    t.check_constraint "role::text = ANY (ARRAY['Gerente de tienda'::character varying, 'Colaborador'::character varying]::text[])", name: "tbusers_role_check"
    t.unique_constraint ["user_username"], name: "tbusers_user_username_key"
  end

  create_table "tbviajes", primary_key: "viaj_id", id: :serial, force: :cascade do |t|
    t.integer "sucu_id"
    t.integer "user_user_id"
    t.integer "trans_id"
    t.date "viaj_fecha", null: false
    t.decimal "total_km", precision: 5, scale: 2, null: false
    t.decimal "total_a_pagar", precision: 10, scale: 2, null: false
    t.check_constraint "total_km <= 100::numeric", name: "tbviajes_total_km_check"
  end

  create_table "tbviajes_detalle", primary_key: "vide_id", id: :serial, force: :cascade do |t|
    t.integer "viaj_id"
    t.integer "cola_id"
    t.decimal "distancia_km", precision: 5, scale: 2, null: false

    t.unique_constraint ["viaj_id", "cola_id"], name: "tbviajes_detalle_viaj_id_cola_id_key"
  end

  add_foreign_key "tbcolaboradores_por_sucursales", "tbcolaboradores", column: "cola_id", primary_key: "cola_id", name: "tbcolaboradores_por_sucursales_cola_id_fkey", on_delete: :cascade
  add_foreign_key "tbcolaboradores_por_sucursales", "tbsucursales", column: "sucu_id", primary_key: "sucu_id", name: "tbcolaboradores_por_sucursales_sucu_id_fkey", on_delete: :cascade
  add_foreign_key "tbviajes", "tbsucursales", column: "sucu_id", primary_key: "sucu_id", name: "tbviajes_sucu_id_fkey", on_delete: :cascade
  add_foreign_key "tbviajes", "tbtransportistas", column: "trans_id", primary_key: "trans_id", name: "tbviajes_trans_id_fkey", on_delete: :cascade
  add_foreign_key "tbviajes", "tbusers", column: "user_user_id", primary_key: "user_user_id", name: "tbviajes_user_user_id_fkey", on_delete: :cascade
  add_foreign_key "tbviajes_detalle", "tbcolaboradores", column: "cola_id", primary_key: "cola_id", name: "tbviajes_detalle_cola_id_fkey", on_delete: :cascade
  add_foreign_key "tbviajes_detalle", "tbviajes", column: "viaj_id", primary_key: "viaj_id", name: "tbviajes_detalle_viaj_id_fkey", on_delete: :cascade
end
