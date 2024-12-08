class User < ApplicationRecord
  self.table_name = "tbusers"
  validates :user_username, uniqueness: true
  validates :user_password_hash, presence: true
  validates :role, inclusion: { in: [ "Gerente de tienda", "Colaborador" ] }
end
