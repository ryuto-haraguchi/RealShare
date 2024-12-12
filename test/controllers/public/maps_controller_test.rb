require "test_helper"

class Public::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_maps_index_url
    assert_response :success
  end
end
