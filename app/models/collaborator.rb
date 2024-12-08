class Collaborator < ApplicationRecord
  self.table_name = "tbcolaboradores"

  validates :cola_nombre, presence: true
  validates :cola_apelllido, presence: true
  validates :cola_sexo, inclusion: { in: [ "M", "F" ], message: "%{value} no es válido" }
  validates :cola_email, presence: true, uniqueness: true
  validates :cola_direccion_casa, presence: true

  has_many :tbviajes_colaboradores
  has_many :viajes, through: :tbviajes_colaboradores
  has_many :tbcolaboradores_por_sucursales, class_name: "TbcolaboradoresPorSucursales", foreign_key: "cola_id"
  has_many :sucursales, through: :tbcolaboradores_por_sucursales, source: :sucursal
end
