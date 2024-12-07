require "test_helper"

class Public::GroupUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_group_users_index_url
    assert_response :success
  end
end
