class ViajesController < ApplicationController
  before_action :set_viaje, only: [ :destroy ]
  def index
    viajes = ActiveRecord::Base.connection.execute("SELECT * FROM obtener_viajes_con_suma_km()")
    render json: viajes, status: :ok
  end

  def create
    puts params.inspect
    params[:sucu_id] = params.delete(:sucursal_id)
  params[:trans_id] = params.delete(:transportista_id)
    @viaje = Viaje.new(viaje_params)
  @viaje.user_user_id = 1
  if @viaje.user_user_id == 1
    params[:colaboradores].each do |colaborador_id|
      TbviajesColaboradores.create(
        viaj_id: @viaje.id,
        cola_id: colaborador_id
      )

      ActiveRecord::Base.connection.execute(
        "SELECT insertar_viaje(#{@viaje.user_user_id}, #{@viaje.sucu_id}, #{@viaje.trans_id}, ARRAY[#{params[:colaboradores].join(',')}], '#{@viaje.viaj_fecha}')")
        end
    render json: @viaje, status: :created

  else
      puts @viaje.errors.full_messages
      render json: { errors: @viaje.errors.full_messages }, status: :unprocessable_entity
  end
  end

  def update
    if @viaje.update(viaje_params)
      ActiveRecord::Base.connection.execute("SELECT actualizar_viaje(#{@viaje.viaj_id}, #{@viaje.user_user_id}, #{@viaje.sucu_id}, #{@viaje.trans_id}, ARRAY[#{@viaje.colaboradores_ids.join(',')}], '#{@viaje.fecha_viaje}')")
      puts "sucu_id: #{@viaje.sucu_id}, trans_id: #{@viaje.trans_id}, colaboradores: #{params[:colaboradores].inspect}"
      redirect_to @viaje, notice: "Viaje actualizado exitosamente."
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.connection.execute("SELECT eliminar_viaje(#{@viaje.viaj_id})")
    redirect_to viajes_url, notice: "Viaje eliminado exitosamente."
  end

  private

  def set_viaje
    @viaje = Viaje.find(params[:id])
  end

  def viaje_params
    params[:viaj_fecha] = DateTime.parse(params[:viaj_fecha]) if params[:viaj_fecha].is_a?(String)
    params.permit(:viaj_fecha, :sucu_id, :trans_id)
  end
end
