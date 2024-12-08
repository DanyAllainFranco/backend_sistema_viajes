class Transportistum < ApplicationRecord
  self.table_name = "tbtransportistas"

  validates :trans_nombre, presence: true
  validates :trans_apellido, presence: true
  validates :tarifa_por_km, numericality: { greater_than: 0 }

  has_many :viajes, class_name: "Viaje", foreign_key: "trans_id"
end
