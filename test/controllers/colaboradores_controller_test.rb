require "test_helper"

class ColaboradoresControllerTest < ActionDispatch::IntegrationTest
  test "should get asignar_sucursal" do
    get colaboradores_asignar_sucursal_url
    assert_response :success
  end
end
