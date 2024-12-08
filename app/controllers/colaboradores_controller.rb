class ColaboradoresController < ApplicationController
  before_action :find_colaborador, only: [ :asignar_sucursal, :actualizar_sucursal, :eliminar_sucursal,  :ver_sucursal ]

  def index
    collaborators_with_branches = ActiveRecord::Base.connection.execute("SELECT*FROM get_colaboradores()")
    render json: collaborators_with_branches, status: :ok
  end

  def listar_sucursales_con_colaborador
    sucursales_asignadas = ActiveRecord::Base.connection.execute("SELECT * FROM obtener_sucursales_asignadas()")
    render json: sucursales_asignadas, status: :ok
  end

    def asignar_sucursal
      colaborador_id = params[:id]
      sucursal_id = params[:sucursal_id]
      distancia_km = params[:distancia_km]

      @colaborador = Collaborator.find(colaborador_id)

      if distancia_km <= 0 || distancia_km > 50
        return render json: { error: "La distancia debe ser mayor a 0 y menor o igual a 50 km." }, status: :unprocessable_entity
      end

      if @colaborador.tbcolaboradores_por_sucursales.exists?(sucu_id: sucursal_id)
        return render json: { error: "El colaborador ya tiene esta sucursal asignada." }, status: :unprocessable_entity
      end

      @colaborador.tbcolaboradores_por_sucursales.create!(sucu_id: sucursal_id, distancia_km: distancia_km)

      render json: { message: "Sucursal asignada correctamente" }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def ver_sucursal
      sucursal = @colaborador.sucursales.find_by(sucu_id: params[:sucu_id])

      if sucursal
        render json: sucursal, status: :ok
      else
        render json: { error: "Sucursal no encontrada" }, status: :not_found
      end
    end


    def actualizar_sucursal
      colaborador = find_colaborador
      sucursal = Sucursal.find(params[:sucu_id])

      colaborador_por_sucursal = TbcolaboradoresPorSucursales.find_or_initialize_by(cola_id: colaborador.id, sucu_id: sucursal.id)

      colaborador_por_sucursal.distancia_km = params[:colaboradore][:distancia_km]

      if colaborador_por_sucursal.save
        render json: { message: "Sucursal actualizada correctamente" }, status: :ok
      else
        render json: { errors: colaborador_por_sucursal.errors.full_messages }, status: :unprocessable_entity
      end
    end

  def eliminar_sucursal
    sucursal_id = params[:sucu_id]

    asignacion = @colaborador.sucursales.find_by(sucu_id: sucursal_id)

    if asignacion
      asignacion.destroy!
      render json: { message: "Sucursal eliminada correctamente" }, status: :ok
    else
      render json: { error: "Asignación no encontrada" }, status: :not_found
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def listar_por_sucursal
    sucursal_id = params[:sucu_id]
    sucursal = Sucursal.find_by(sucu_id: sucursal_id)
    if sucursal.nil?
      render json: { error: "Sucursal no encontrada" }, status: :not_found
      return
    end
    query = "SELECT * FROM get_colaboradores_por_sucursal(#{sucursal_id})"
    colaboradores = ActiveRecord::Base.connection.execute(query)
    colaboradores = colaboradores.map { |colaborador| colaborador.symbolize_keys }
    render json: colaboradores, status: :ok
  end

  private

  def colaborador_params
    params.require(:colaboradore).permit(:distancia_km, :sucu_id)
  end

  def find_colaborador
    @colaborador = Collaborator.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Colaborador no encontrado" }, status: :not_found
  end
end
