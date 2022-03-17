require "test_helper"

class Public::CarItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_car_items_index_url
    assert_response :success
  end
end
