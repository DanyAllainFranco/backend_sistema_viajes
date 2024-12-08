class TbcolaboradoresPorSucursales < ApplicationRecord
  self.table_name = "tbcolaboradores_por_sucursales"

   belongs_to :colaborador, foreign_key: "cola_id", class_name: "Collaborator"
  belongs_to :sucursal, foreign_key: "sucu_id", class_name: "Sucursal"

  belongs_to :collaborator, foreign_key: "cola_id"
  belongs_to :sucursal, foreign_key: "sucu_id"
  validates :distancia_km, numericality: { greater_than: 0, less_than_or_equal_to: 50 }
  validates :sucu_id, uniqueness: { scope: :cola_id, message: "El colaborador ya tiene esta sucursal asignada" }
end
