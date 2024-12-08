class TbviajesColaboradores < ApplicationRecord
  self.table_name = "tbviajes_colaboradores"

   belongs_to :viaje, class_name: "Viaje", foreign_key: "viaj_id"
   belongs_to :colaborador, class_name: "Collaborator", foreign_key: "cola_id"
end
