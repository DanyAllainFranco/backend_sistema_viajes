class Viaje < ApplicationRecord
  self.table_name = "tbviajes"

  belongs_to :sucursal, class_name: "Sucursal", foreign_key: "sucu_id"
  belongs_to :transportista, class_name: "Transportistum", foreign_key: "trans_id"
  belongs_to :user, class_name: "User", foreign_key: "user_user_id"

  has_many :tbviajes_colaboradores, class_name: "TbviajesColaboradores"
  has_many :colaboradores, through: :tbviajes_colaboradores

  has_many :viajes_detalles, class_name: "ViajeDetalle", foreign_key: "viaj_id"
end
