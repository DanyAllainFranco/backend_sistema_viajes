require "test_helper"

class ReportesControllerTest < ActionDispatch::IntegrationTest
  test "should get viajes" do
    get reportes_viajes_url
    assert_response :success
  end
end
