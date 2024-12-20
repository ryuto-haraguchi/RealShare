require "test_helper"

class Public::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_notices_new_url
    assert_response :success
  end
end
