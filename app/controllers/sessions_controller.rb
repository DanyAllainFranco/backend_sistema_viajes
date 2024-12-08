class SessionsController < ApplicationController
  def create
    begin
      puts "Parámetros recibidos: #{params.inspect}"

      username = params[:user_username]
      password = params[:user_password_hash]

      if username.blank? || password.blank?
        render json: { message: "Faltan credenciales" }, status: :bad_request
        return
      end

      sanitized_query = ActiveRecord::Base.sanitize_sql_array(
        [ "SELECT * FROM validar_usuario(?, ?)", username, password ]
      )

      result = ActiveRecord::Base.connection.exec_query(sanitized_query).to_a.first

      if result && result["autenticado"]
        token = JWT.encode({ user_id: result["user_id"], role: result["role"] }, "secret_key", "HS256")
        render json: { token: token, role: result["role"] }, status: :ok
      else
        render json: { message: "Credenciales inválidas" }, status: :unauthorized
      end
    rescue => e
      # Manejar cualquier error interno
      puts "Error interno: #{e.message}"
      render json: { message: "Error interno del servidor: #{e.message}" }, status: :internal_server_error
    end
  end
end
