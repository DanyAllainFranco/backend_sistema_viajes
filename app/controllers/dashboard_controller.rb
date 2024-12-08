class DashboardController < ApplicationController
  def metricas
    viajes_por_sucursal = ActiveRecord::Base.connection.exec_query("SELECT * FROM obtener_viajes_por_sucursal()").rows.map do |row|
      { sucursal_nombre: row[0], cantidad_viajes: row[1] }
    end

    transportistas_activos = ActiveRecord::Base.connection.exec_query("SELECT * FROM obtener_transportistas_activos_viajes()").rows.map do |row|
      { transportista_nombre: row[0], viajes_realizados: row[1] }
    end

    colaboradores_activos = ActiveRecord::Base.connection.exec_query("SELECT * FROM obtener_colaboradores_activos_viajes()").rows.map do |row|
      { colaborador_nombre: row[0], viajes_realizados: row[1] }
    end

    metricas = {
      cantidadViajes: ActiveRecord::Base.connection.exec_query("SELECT obtener_cantidad_viajes()").rows.flatten.first,
      totalKm: ActiveRecord::Base.connection.exec_query("SELECT obtener_total_km()").rows.flatten.first,
      totalDinero: ActiveRecord::Base.connection.exec_query("SELECT obtener_total_dinero()").rows.flatten.first,
      promedioDistancia: ActiveRecord::Base.connection.exec_query("SELECT obtener_promedio_distancia()").rows.flatten.first,
      viajesPorSucursal: viajes_por_sucursal,
      transportistasActivos: transportistas_activos,
      colaboradoresActivos: colaboradores_activos
    }

    render json: metricas
  end
end
