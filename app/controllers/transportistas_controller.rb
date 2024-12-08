class TransportistasController < ApplicationController
  def index
    transportistas = Transportistum.all

    render json: transportistas.map { |t|
      {
        trans_id: t.id,
        trans_nombre: t.trans_nombre,
        trans_apellido: t.trans_apellido,
        tarifa_por_km: t.tarifa_por_km
      }
    }, status: :ok
  end
end
