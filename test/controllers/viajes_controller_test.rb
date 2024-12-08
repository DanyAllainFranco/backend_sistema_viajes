require "test_helper"

class ViajesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get viajes_create_url
    assert_response :success
  end
end
