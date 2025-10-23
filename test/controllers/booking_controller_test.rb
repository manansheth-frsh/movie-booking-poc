require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get booking_index_url
    assert_response :success
  end
end
