class SucursalesController < ApplicationController
  def index
    sucursales = Sucursal.all
    render json: sucursales, status: :ok
  end

  def asignar_sucursal_a_colaborador
    colaborador_id = params[:colaborador_id]
    sucursal_id = params[:sucursal_id]
    distancia_km = params[:distancia_km]

    if colaborador_id.nil? || sucursal_id.nil? || distancia_km.nil?
      render json: { error: "Faltan parámetros requeridos" }, status: :unprocessable_entity
      return
    end

    # Llamar al procedimiento en PostgreSQL
    ActiveRecord::Base.connection.execute("SELECT asignar_sucursal_a_colaborador(#{colaborador_id}, #{sucursal_id}, #{distancia_km})")

    render json: { message: "Asignación realizada correctamente" }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def actualizar_sucursal_a_colaborador
    cosu_id = params[:cosu_id]
    distancia_km = params[:distancia_km]

    # Llamar al procedimiento en PostgreSQL
    ActiveRecord::Base.connection.execute("SELECT actualizar_sucursal_a_colaborador(#{cosu_id}, #{distancia_km})")

    render json: { message: "Asignación actualizada correctamente" }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def eliminar_sucursal_a_colaborador
    cosu_id = params[:cosu_id]

    # Llamar al procedimiento en PostgreSQL
    ActiveRecord::Base.connection.execute("SELECT eliminar_sucursal_a_colaborador(#{cosu_id})")

    render json: { message: "Asignación eliminada correctamente" }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def listar_asignaciones
    asignaciones = ActiveRecord::Base.connection.execute("SELECT * FROM listar_asignaciones_sucursales()")
    render json: asignaciones, status: :ok
  end
end
