class ViajeDetalle < ApplicationRecord
  self.table_name = "tbviajes_detalle"
  belongs_to :viaje
  belongs_to :colaborador
  validates :distancia_km, numericality: { greater_than: 0 }

  belongs_to :viaje, class_name: "Viaje", foreign_key: "viaj_id"
end
