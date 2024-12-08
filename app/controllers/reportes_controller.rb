class ReportesController < ApplicationController
  def reporte
    # Parámetros recibidos
    trans_id = params[:trans_id]
    fecha_inicio = params[:fecha_inicio]
    fecha_fin = params[:fecha_fin]


    result = ActiveRecord::Base.connection.execute(
      "SELECT * FROM obtener_reporte_viajes(#{trans_id}, '#{fecha_inicio}', '#{fecha_fin}')"
    )

    viajes_resultados = result.map do |viaje|
      {
        viaje_id: viaje["viaje_id"],
        total_distancia: viaje["total_distancia"],
        total_a_pagar: viaje["total_a_pagar"],
        colaborador_id: viaje["colaborador_id"],
        colaborador_nombre: viaje["colaborador_nombre"],
        veces_viajaron: viaje["veces_viajaron"],
        sucursal_nombre: viaje["sucursal_nombre"],
        direccion_casa: viaje["direccion_casa"]
      }
    end

    render json: { viajes: viajes_resultados }, status: :ok
  end
end
