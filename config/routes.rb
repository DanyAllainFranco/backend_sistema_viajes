Rails.application.routes.draw do
  get "/api/reportes/viajes", to: "reportes#reporte"

  get "/api/listarviajes", to: "viajes#index"
  post "/api/crearviajes", to: "viajes#create"
  put "/api/editarviaje/:id", to: "viajes#update"
  delete "/api/eliminarviaje/:id", to: "viajes#destroy"

  get "/api/dashboard/metricas", to: "dashboard#metricas"

  get "/api/colaboradores/:id/sucursales/:sucu_id", to: "colaboradores#ver_sucursal"

  post "/api/colaboradores/:id/sucursales", to: "colaboradores#asignar_sucursal"
  put "/api/colaboradores/:id/sucursales/:sucu_id", to: "colaboradores#actualizar_sucursal"
  delete "/api/colaboradores/:id/sucursales/:sucu_id", to: "colaboradores#eliminar_sucursal"
  get "/api/colaboradores/:id/sucursales", to: "colaboradores#listar_sucursales"
  get "/api/colaboradores/sucursales/:sucu_id", to: "colaboradores#listar_por_sucursal"

  get "/api/colaboradores/sucursalesconcolaborador", to: "colaboradores#listar_sucursales_con_colaborador"

  get "/api/transportistas", to: "transportistas#index"

  post "/api/login", to: "sessions#create"

  get "/api/colaboradores", to: "colaboradores#index"

  get "/api/sucursales", to: "sucursales#index"
end
