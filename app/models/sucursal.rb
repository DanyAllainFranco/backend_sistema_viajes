class Sucursal < ApplicationRecord
  self.table_name = "tbsucursales"

  validates :sucu_nombre, presence: true
  validates :sucu_direccion, presence: true

  has_many :tbcolaboradores_por_sucursales, class_name: "TbcolaboradoresPorSucursales", foreign_key: "sucu_id"
  has_many :collaborators, through: :tbcolaboradores_por_sucursales, source: :collaborator
end
